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
        addRandomSnakeAndLadder(count: 3)
        createPlayers(name: "", token: "")
        playerCounter = 0
        //    playGame()
    }

    private mutating func createPlayers(name: String, token: String) {
        for i in 0...AppConfig.numberofPlayers - 1 {
            players.append(Player(playerID: i, name: name, token: token)) //add function to get player input and
            addPlayerToTile(playerId: i, tileId: 1)
        }
    }

    private mutating func resetBoard() {
        AppConfig.tileStartId = 0
        tiles = [Tile]()
        for i in stride(from: AppConfig.boardSize, to: AppConfig.boardSize - (AppConfig.boardSize / AppConfig.boardLength), by: -1) {
            tiles.append(Tile(tId: i, tSnakeOrLadder: (tileType.none, -1)))
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
                tiles.append(Tile(tId: tmpId[i], tSnakeOrLadder: (tileType.none, -1)))
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

    mutating private func addRandomSnakeAndLadder(count: Int) {
        for _ in 0...count - 1 {
            let isSnake = Bool.random()
            var startingPosition = Int.random(in: 2...AppConfig.boardSize - 1)
            var length = lengthSnakeAndLadder.allCases.randomElement()!.value
            while doesSnakeOrLadderViolateConstraints(isSnake: isSnake, start: startingPosition, length: length) {
                startingPosition = Int.random(in: 2...AppConfig.boardSize - 1)
                length = lengthSnakeAndLadder.allCases.randomElement()!.value
            }
            let endingPosition = returnEndingPosition(isSnake: isSnake, start: startingPosition, length: length)
            Log.log("count: \(count) snake? \(isSnake) start \(startingPosition) length \(length)", level: .trace)
            tiles[getTileIndexFromId(tileId: startingPosition)].tSnakeOrLadder = (isSnake ? tileType.snakeStart : tileType.ladderStart, endingPosition)
        }
    }

    mutating private func doesSnakeOrLadderViolateConstraints(isSnake: Bool, start: Int, length: Int) -> Bool {
        if tiles[getTileIndexFromId(tileId: start)].tSnakeOrLadder.status != .none {
            return true
        }
        let endingPosition = returnEndingPosition(isSnake: isSnake, start: start, length: length)
        if tiles[getTileIndexFromId(tileId: endingPosition)].tSnakeOrLadder.status != .none {
            return true
        }
        return isSnake ? endingPosition <= 1: endingPosition >= AppConfig.boardSize
    }

    mutating func returnEndingPosition(isSnake: Bool, start: Int, length: Int) -> Int {
        return start + (isSnake ? -1 : 1) * length
    }


    mutating private func updatePlayerPosition(playerId: Int, tileId: Int) {
        if tileId > -1 && tileId <= AppConfig.boardSize {
            removePlayerFromTile(playerId: playerId)
            addPlayerToTile(playerId: playerId, tileId: tileId)
        }
    }

    mutating private func updatePlayerPosition(player: Player, tileId: Int) {
        updatePlayerPosition(playerId: player.getId(), tileId: tileId)
    }

    mutating private func addPlayerToTile(playerId: Int, tileId: Int) {
        tiles[getTileIndexFromId(tileId: tileId)].addPlayer(playerId: playerId)
        players[playerId].setPosition(position: tileId)
        Log.log("Added to tileID: \(tileId) \(tiles[tileId].tOccupiedBy)", level: .trace)
    }

    mutating private func removePlayerFromTile(playerId: Int) {
        let currentPosition = players[playerId].getPosition()
        Log.log("playerID: \(playerId) currentpos: \(currentPosition)", level: .trace)
        tiles[getTileIndexFromId(tileId: currentPosition)].removePlayer(playerId: playerId)
        Log.log("Removed from tileID: \(currentPosition) \(tiles[currentPosition].tOccupiedBy)", level: .trace
        )
    }

    mutating func playGame() {
        while !isGameOver {
            players.forEach { player in
                Log.log(player.getId(), level: .debug)
                Dice.roll()
                let roll = Dice.returnRollSum()
                let outcome = checkOutcomeOfRoll(player: player, roll: roll)
                updatePlayerPosition(player: player, tileId: outcome.newPosition)
                delegate?.playerDidSomething(self, text: String(outcome.newPosition))
                if outcome.win {
                    isGameOver = true
                    return

                }

            }

        }
    }

    mutating func playTurn() -> (currentIndex: Int,newIndex: Int, terminusIndex: Int){


        Log.log(playerCounter, level: .debug)
        let currentPosition = players[playerCounter].getPosition()

        Dice.roll()
        let roll = Dice.returnRollSum()
        let outcome = checkOutcomeOfRoll(player: players[playerCounter], roll: roll)
        updatePlayerPosition(player: players[playerCounter], tileId: outcome.newPosition)
        if outcome.terminus > -1 {
            updatePlayerPosition(player: players[playerCounter], tileId: outcome.terminus)
        }
        if roll != 6 {
            playerCounter = playerCounter == AppConfig.numberofPlayers - 1 ? 0 : playerCounter + 1
        }
        delegate?.playerDidSomething(self, text: String("Player: \(playerCounter) to Play"))

        return (getTileIndexFromId(tileId: currentPosition) , getTileIndexFromId(tileId: outcome.newPosition), getTileIndexFromId(tileId: outcome.terminus) )

    }

    private func checkOutcomeOfRoll(player: Player, roll: Int) -> (win: Bool, newPosition: Int, terminus: Int) {
        var newPosition = player.getPosition() + roll
        var terminus = -1
        if newPosition > AppConfig.boardSize || newPosition < 1 {
            newPosition = player.getPosition()
        } else {
            let newTile = tiles[getTileIndexFromId(tileId: newPosition)].tSnakeOrLadder
            if newTile.status != .none {
                terminus = newTile.terminus
            }
        }
        let win = newPosition == AppConfig.boardSize ? true : false
        return (win, newPosition, terminus)
    }

    private func getTileIndexFromId(tileId: Int) -> Int {
        for index in 0...AppConfig.boardSize - 1 {
            if tiles[index].tId == tileId {
                return index
            }
        }
        return 0
    }
}









