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
    
    init() {
        tiles = [Tile]()
        self.players = [Player]()
    }
    
    mutating func startNewGame(players: [Player]) {
        self.players = players
        resetBoard()
        setPlayers()
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
        Log.log(tiles, level: .trace)
    }
    
    private mutating func setPlayers() {
        for i in 1...AppConfig.numberofPlayers {
            players[i - 1].startNewGame()
            addPlayerToTile(playerID: i - 1, tileId: 0)
        }
    }
    
    func getTileInfo(index: Int) -> Tile {
        return tiles[index]
    }
    
    mutating private func addPlayerToTile(playerID: Int, tileId: Int){
        tiles[tileId].addPlayer(playerID: playerID)
    }
}







