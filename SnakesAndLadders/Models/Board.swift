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
    
    init() {
        tiles = [Tile]()
        resetBoard()
    }
    
    mutating func resetBoard() {
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
    
    func getTileInfo(index: Int) -> Tile {
        return tiles[index]
    }
}







