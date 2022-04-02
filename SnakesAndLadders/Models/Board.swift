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
    private var isGameOver: Bool = false
    private var playerCounter: Int = 0
    private var isGameWon: Bool = false
    var delegate: BoardDelegate?
    
    init() {
        tiles = [Tile]()
        players = [Player]()
    }
    
    mutating func startNewGame() {
        isGameWon = false
        isGameOver = true
        resetBoard()
        addRandomSpecialTiles(count: 3, isSnakeAndLadder: true)
        addRandomSpecialTiles(count: 3, isSnakeAndLadder: false)
        createPlayers(name: "", token: "")
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
    
    mutating private func addRandomSpecialTiles(count: Int = 0, isSnakeAndLadder: Bool = true) {
        for _ in 0...count - 1 {
            let isFirstValue = Bool.random()
            var startingPosition = Int.random(in: 2...AppConfig.boardSize - 1)
            var length = isSnakeAndLadder ? lengthSnakeAndLadder.allCases.randomElement()!.value : 0
            while doesSpecialTileViolateConstraints(isFirstValue: isFirstValue, start: startingPosition, length: length) {
                startingPosition = Int.random(in: 2...AppConfig.boardSize - 1)
                length = isSnakeAndLadder ? lengthSnakeAndLadder.allCases.randomElement()!.value : 0
            }
            do {
                let endingPosition = isSnakeAndLadder ? try Tile.returnEndingPosition(isSnake: isFirstValue, start: startingPosition, length: length) : startingPosition
                Log.log("count: \(count) isSnakeAndLadder: \(isSnakeAndLadder)  isFirstValue? \(isFirstValue) start \(startingPosition) length \(length)", level: .trace)
                tiles[getTileIndexFromId(startingPosition)].tType = isSnakeAndLadder ? (isFirstValue ? TileType.snake : TileType.ladder, endingPosition) : (isFirstValue ? TileType.slow : TileType.fast, endingPosition)
            } catch {
                return
            }
        }
    }
    
    mutating private func doesSpecialTileViolateConstraints(isFirstValue: Bool, start: Int, length: Int = 0) -> Bool {
        if tiles[getTileIndexFromId(start)].tType.status != .normal {
            return true
        }
        do {
            let endingPosition = try Tile.returnEndingPosition(isSnake: isFirstValue, start: start, length: length)
            if tiles[getTileIndexFromId(endingPosition)].tType.status != .normal {
                return true
            }
        } catch {
            return true
        }
        return false
    }
    

    
    mutating func playTurn() -> (currentIndex: Int,newIndex: Int, terminusIndex: Int){
        let currentPosition = players[playerCounter].getPosition()
        let newPosition = players[playerCounter].playerRollsDice()
        let newTile = tiles[getTileIndexFromId(newPosition)].tType
        let terminus = players[playerCounter].playerHasComeToSpecialTile(status: newTile.status, terminus: newTile.terminus)
        if Dice.returnRollSum() != 6 {
            playerCounter = playerCounter == AppConfig.numberofPlayers - 1 ? 0 : playerCounter + 1
        }
        delegate?.playerDidSomething(self, text: String("Player: \(playerCounter) to Play"))
        isGameWon = newPosition == AppConfig.boardSize ? true : false
        return (getTileIndexFromId(currentPosition) , getTileIndexFromId(newPosition), getTileIndexFromId(terminus) )
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
}









