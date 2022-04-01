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
    var delegate: BoardDelegate?
    
    init() {
        tiles = [Tile]()
        players = [Player]()
    }
    
    mutating func startNewGame() {
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
            Log.log("Added to tileID: 1 \(tiles[1].tOccupiedBy)", level: .trace)
        }
    }
    
    private mutating func resetBoard() {
        AppConfig.tileStartId = 0
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
            Log.log("index \(i) id \(tiles[i].tId) pos \(tiles[i].tIndex)", level: .trace)
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
            let endingPosition = isSnakeAndLadder ? returnEndingPosition(isSnake: isFirstValue, start: startingPosition, length: length) : startingPosition
            Log.log("count: \(count) isSnakeAndLadder: \(isSnakeAndLadder)  isFirstValue? \(isFirstValue) start \(startingPosition) length \(length)", level: .trace)
            tiles[getTileIndexFromId(tileId: startingPosition)].tType = isSnakeAndLadder ? (isFirstValue ? tileType.snakeStart : tileType.ladderStart, endingPosition) : (isFirstValue ? tileType.slowStart : tileType.fastStart, endingPosition)
        }
    }
    
    mutating private func doesSpecialTileViolateConstraints(isFirstValue: Bool, start: Int, length: Int = 0) -> Bool {
        if tiles[getTileIndexFromId(tileId: start)].tType.status != .none {
            return true
        }
        let endingPosition = returnEndingPosition(isSnake: isFirstValue, start: start, length: length)
        if length != 0 {
            if isFirstValue && endingPosition <= 1 {
                return true
            }
            if !isFirstValue && endingPosition >= AppConfig.boardSize {
                return true
            }
        }
        if tiles[getTileIndexFromId(tileId: endingPosition)].tType.status != .none {
            return true
        }
        return false
    }
    
    mutating func returnEndingPosition(isSnake: Bool, start: Int, length: Int) -> Int {
        return start + (isSnake ? -1 : 1) * length
    }
    
    
    mutating private func updatePlayerPosition(playerId: Int, tileId: Int) {
        if tileId > -1 && tileId <= AppConfig.boardSize {
            let currentPosition = getPlayerPositionFromTiles(playerId: playerId)
            tiles[getTileIndexFromId(tileId: currentPosition)].removePlayer(playerId: playerId)
            Log.log("Removed from tileID: \(currentPosition) \(tiles[currentPosition].tOccupiedBy)", level: .trace
            )
            tiles[getTileIndexFromId(tileId: tileId)].addPlayer(playerId: playerId)
            Log.log("Added to tileID: \(tileId) \(tiles[tileId].tOccupiedBy)", level: .trace
            )
        }
    }
    
    mutating func playGame() {
        while !isGameOver {
            players.forEach { player in
                Log.log(player.getId(), level: .debug)
                Dice.roll()
                let roll = Dice.returnRollSum()
                let outcome = checkOutcomeOfRoll(playerId: player.getId(), roll: roll)
                updatePlayerPosition(playerId: player.getId(), tileId: outcome.newPosition)
                delegate?.playerDidSomething(self, text: String(outcome.newPosition))
                if outcome.win {
                    isGameOver = true
                    return
                }
            }
        }
    }
    
    mutating func playTurn() -> (currentIndex: Int,newIndex: Int, terminusIndex: Int){
        Log.log(playerCounter, level: .trace)
        let currentPosition = getPlayerPositionFromTiles(playerId: playerCounter)
        Dice.roll()
        let roll = Dice.returnRollSum()
        let outcome = checkOutcomeOfRoll(playerId: playerCounter, roll: roll)
        updatePlayerPosition(playerId: playerCounter, tileId: outcome.newPosition)
        if outcome.terminus > -1 {
            updatePlayerPosition(playerId: playerCounter, tileId: outcome.terminus)
        }
        if roll != 6 {
            playerCounter = playerCounter == AppConfig.numberofPlayers - 1 ? 0 : playerCounter + 1
        }
        delegate?.playerDidSomething(self, text: String("Player: \(playerCounter) to Play"))
        return (getTileIndexFromId(tileId: currentPosition) , getTileIndexFromId(tileId: outcome.newPosition), getTileIndexFromId(tileId: outcome.terminus) )
    }
    
    private mutating func checkOutcomeOfRoll(playerId: Int, roll: Int) -> (win: Bool, newPosition: Int, terminus: Int) {
        let currentPosition = getPlayerPositionFromTiles(playerId: playerId)
        let modifiedRoll = players[playerId].nextTurnValue(roll: roll)
        var newPosition = currentPosition + modifiedRoll
        var terminus = -1
        if newPosition > AppConfig.boardSize || newPosition < 1 {
            newPosition = currentPosition
        } else {
            let newTile = tiles[getTileIndexFromId(tileId: newPosition)].tType
            switch newTile.status {
            case .snakeStart:
                terminus = newTile.terminus
            case .fastStart:
                players[playerId].setNextTurnType(turnType: .fast)
            case .ladderStart:
                terminus = newTile.terminus
            case .slowStart:
                players[playerId].setNextTurnType(turnType: .slow)
            case .none:
                terminus = -1
            }
        }
        let win = newPosition == AppConfig.boardSize ? true : false
        return (win, newPosition, terminus)
    }
    
    private func getTileIndexFromId(tileId: Int) -> Int {
        return (tiles.filter() {$0.tId == tileId})[0].tIndex
    }
    private func getPlayerPositionFromTiles(playerId: Int) -> Int {
        return (tiles.filter() {$0.tOccupiedBy[playerId] == true})[0].tId
    }
}









