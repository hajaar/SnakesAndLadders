    //
    //  Board.swift
    //  SnakesAndLadders
    //
    //  Created by Kartik Narayanan on 15/03/22.
    //

import Foundation
import UIKit

protocol BoardDelegate {
    func playerDidSomething(_ controller: Board, text: String)
}


struct Board {
    private var tiles: [Tile]
    private var players: [Player]
    private var snakesAndLadders: [SnakeAndLadder]
    private var isGameOver: Bool = false
    private var playerCounter: Int = 0
    private var isGameWon: Bool = false
    var delegate: BoardDelegate?
    
    init() {
        tiles = [Tile]()
        players = [Player]()
        snakesAndLadders = [SnakeAndLadder]()
    }
    
    mutating func startNewGame() {
        isGameWon = false
        isGameOver = true
        resetBoard()
        createPlayers(name: "", token: "")
        addRandomSnakesAndLadders(count: 3)

        playerCounter = 0
            //    playGame()
    }
    
    private mutating func createPlayers(name: String, token: String) {
        for i in 0...AppConfig.numberofPlayers - 1 {
            players.append(Player(playerID: i, name: name, token: token)) //add function to get player input and
        }
    }
    
    private mutating func resetBoard() {
        tiles = [Tile]()
        for i in stride(from: AppConfig.boardSize, to: AppConfig.boardSize - (AppConfig.boardSize / AppConfig.boardLength), by: -1) {
            tiles.append(Tile(tId: i))
        }
        var start = 0
        var end = start + (AppConfig.boardSize / AppConfig.boardLength)
        for _ in 1...AppConfig.boardLength {
            var tmpId = [Int]()
            for i in start...end - 1 {
                tmpId.append(tiles[i].tId - AppConfig.boardLength)
                
            }
            tmpId = tmpId.reversed()
            for i in 0...AppConfig.boardLength - 1 {
                tiles.append(Tile(tId: tmpId[i]))
            }
            start = end
            end = start + (AppConfig.boardSize / AppConfig.boardLength)
        }
        for i in 0...AppConfig.boardSize - 1 {
            tiles[i].tIndex = i
            Tile.mapIdToIndex[tiles[i].tId] = i
        }
    }
    
    func getTileInfo(index: Int) -> Tile {
        return tiles[index]
    }
    

    
    mutating private func addRandomSnakesAndLadders(count: Int = 0) {
        for _ in 0...count - 1{
            let isSnake = Bool.random()
            let tileType = isSnake ? TileType.snake : TileType.ladder
            var startingPosition = Int.random(in: 2...AppConfig.boardSize - 1)
            var length = lengthSnakeAndLadder.allCases.randomElement()!
            var endingPosition = startingPosition

            
            var value = doesSpecialTileViolateConstraints(tileType: tileType, start: startingPosition, length: length)
            endingPosition = value.endingPosition
            while value.valid {
                startingPosition = Int.random(in: 2...AppConfig.boardSize - 1)
                length = lengthSnakeAndLadder.allCases.randomElement()!
                value = doesSpecialTileViolateConstraints(tileType: tileType, start: startingPosition, length: length)
                endingPosition = value.endingPosition
                
            }
            snakesAndLadders.append(SnakeAndLadder(isSnake: isSnake, length: length, start: endingPosition))
        }
    }
    
    
    
//    mutating private func addRandomSpecialTiles(count: Int = 0, specialTile: TileType = .normal) {
//        for _ in 0...count - 1 {
//
//            var tileType: TileType = .normal
//            var startingPosition = Int.random(in: 2...AppConfig.boardSize - 1)
//            var length = 0
//            var endingPosition = startingPosition
//
//            switch specialTile {
//            case .snake, .ladder:
//                length = lengthSnakeAndLadder.allCases.randomElement()!.value
//                tileType =  Bool.random() ? TileType.snake : TileType.ladder
//            case .slow, .fast:
//                tileType = Bool.random() ? TileType.slow : TileType.fast
//            case .normal:
//                return
//            }
//
//            var value = doesSpecialTileViolateConstraints(tileType: tileType, start: startingPosition, length: length)
//            endingPosition = value.endingPosition
//            while value.valid {
//                startingPosition = Int.random(in: 2...AppConfig.boardSize - 1)
//                length = lengthSnakeAndLadder.allCases.randomElement()!.value
//                value = doesSpecialTileViolateConstraints(tileType: tileType, start: startingPosition, length: length)
//                endingPosition = value.endingPosition
//
//            }
//            tiles[getTileIndexFromId(startingPosition)].tType = (tileType, endingPosition)
//        }
//    }
    
    mutating private func doesSpecialTileViolateConstraints(tileType: TileType, start: Int, length: lengthSnakeAndLadder) -> (valid: Bool, endingPosition: Int) {
        var endingPosition = 0
        if isTileSnakeAndLadder(position: start)  {
            return (true, endingPosition)
        }
        do {
            endingPosition = try SnakeAndLadder.returnEndingPosition(tileType: tileType, start: start, length: length)
            if isTileSnakeAndLadder(position: endingPosition) == true {
                return (true, endingPosition)
            }
            return (false, endingPosition)
        } catch {
            return (true, endingPosition)
        }
    }
    
    private func getTileIndexFromId(_ tileId: Int) -> Int {
        return Tile.mapIdToIndex[tileId] ?? -1
    }
    
    
    func getPlayerInfo() -> [(playerId: Int, tileIndex: Int, playerImage: UIImage, playerColor: UIColor)] {
        var returnValue = [(playerId: Int, tileIndex: Int, playerImage: UIImage, playerColor: UIColor)]()
        
        players.forEach { player in
            let tmpId = player.getId()
            let tmpTileIndex = getTileIndexFromId(player.getPosition())
            let tmpPlayerImage = player.getPlayerImage()
            let tmpPlayerColor = player.getPlayerColor()
            returnValue.append((playerId: tmpId, tileIndex: tmpTileIndex, playerImage: tmpPlayerImage, playerColor: tmpPlayerColor))
        }
        return returnValue
    }

    func getSnakeAndLadderInfo() -> [(tileIndex: Int, symbol: UIImage, symbolColor: UIColor)] {
        var returnValue = [(tileIndex: Int, symbol: UIImage, symbolColor: UIColor)]()
        snakesAndLadders.forEach { s in
            let tmpIndex = Tile.mapIdToIndex[s.getStart()]!
            let sym = s.getSymbolImage()
            returnValue.append((tileIndex: tmpIndex, symbol: sym.0, symbolColor: sym.1))
        }
        return returnValue
    }
    
    
    mutating func playTurn() -> (currentIndex: Int,newIndex: Int, terminusIndex: Int){
        let currentPosition = players[playerCounter].getPosition()
        let newPosition = players[playerCounter].playerRollsDice()
        let terminus = getEndOfSnakeAndLadderTileAt(position: newPosition)

        if Dice.returnRollSum() != 6 {
            playerCounter = playerCounter == AppConfig.numberofPlayers - 1 ? 0 : playerCounter + 1
        }
        delegate?.playerDidSomething(self, text: String("Player: \(playerCounter) to Play"))
        isGameWon = newPosition == AppConfig.boardSize ? true : false
        return (getTileIndexFromId(currentPosition) , getTileIndexFromId(newPosition), getTileIndexFromId(terminus) )
    }
    
    private func isTileSnakeAndLadder(position: Int) -> Bool {
        return !snakesAndLadders.filter() {$0.getStart() == position}.isEmpty
    }
    
    private func getEndOfSnakeAndLadderTileAt(position: Int) -> Int {
        var end = position
        if isTileSnakeAndLadder(position: position) {
            end = snakesAndLadders.filter() {$0.getStart() == position}[0].getEnd()
        }
        return end
    }
    
    private func getIndexOfSnakeAndLadderTileAt(position: Int) -> Int {
        for i in 0...snakesAndLadders.count - 1 {
            if snakesAndLadders[i].getStart() == position {
                return i
            }
        }
        return -1
    }

}









