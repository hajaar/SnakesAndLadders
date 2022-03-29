    //
    //  Board.swift
    //  SnakesAndLadders
    //
    //  Created by Kartik Narayanan on 15/03/22.
    //

import Foundation
import UIKit


struct Board {
    private var tiles: [Tile]
    private var players: [Player]
    private var isGameOver: Bool = false
    
    init() {
        tiles = [Tile]()
        self.players = [Player]()
    }
    
    mutating func startNewGame(players: [Player]) {
        self.players = players
        resetBoard()
        setPlayers()
        playGame()
    }
    
    private mutating func resetBoard() {
        tiles = [Tile]()
        for i in stride(from: AppConfig.boardSize, to: AppConfig.boardSize - (AppConfig.boardSize/AppConfig.boardLength), by: -1) {
            tiles.append(Tile(tId: i, tOccupiedBy: [], tSnakeOrLadder: (tileType.none, -1)))
        }
        var start = 0
        var end = start + (AppConfig.boardSize/AppConfig.boardLength)
        for _ in 1...AppConfig.boardLength {
            var tmpId = [Int]()
            for i in start...end-1  {
                tmpId.append(tiles[i].tId - AppConfig.boardLength)
                
            }
            tmpId = tmpId.reversed()
            for i in 0...AppConfig.boardLength - 1{
                tiles.append(Tile(tId: tmpId[i], tOccupiedBy: [], tSnakeOrLadder: (tileType.none, -1)))
            }
            start = end
            end = start + (AppConfig.boardSize/AppConfig.boardLength)
        }
        for i in 0...AppConfig.boardSize - 1 {
            Log.log("index \(i) id \(tiles[i].tId)", level: .trace)
        }
    }
    
    private mutating func setPlayers() {
        for i in 0...AppConfig.numberofPlayers - 1{
            players[i].startNewGame()
            addPlayerToTile(playerId: i, tileId: 0)
        }
    }
    
    func getTileInfo(index: Int) -> Tile {
        return tiles[index]
    }
    
    mutating private func updatePlayerPosition(playerId: Int, tileId: Int){
        if tileId > -1 && tileId < AppConfig.boardSize {
            removePlayerFromTile(playerId: playerId)
            addPlayerToTile(playerId: playerId, tileId: tileId)
        }
    }
    
    mutating private func updatePlayerPosition(player: Player, tileId: Int){
        updatePlayerPosition(playerId: player.getId(), tileId: tileId)
    }
    
    mutating private func addPlayerToTile(playerId: Int, tileId: Int){
        tiles[getTileIndexFromId(tileId: tileId)].addPlayer(playerId: playerId)
        players[playerId].setPosition(position: tileId)
        Log.log("Added to tileID: \(tileId) \(tiles[tileId].tOccupiedBy)", level: .trace)
    }
    
    mutating private func removePlayerFromTile(playerId: Int){
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
                if outcome.win {
                    isGameOver = true
                    return
                }
        }
    }
    }
    
    private func checkOutcomeOfRoll(player: Player, roll: Int) -> (win: Bool, newPosition: Int) {
        var newPosition = player.getPosition() + roll
        newPosition = newPosition >= AppConfig.boardSize - 1 ? AppConfig.boardSize - 1 : newPosition
        let win = newPosition >= AppConfig.boardSize - 1 ? true : false
        return (win,newPosition)
    }
    
    private func getTileIndexFromId(tileId: Int) -> Int {
        for i in 0...AppConfig.boardSize - 1 {
            if tiles[i].tId == tileId {
                return i
            }
        }
        return 0
    }
}









