    //
    //  Board.swift
    //  SnakesAndLadders
    //
    //  Created by Kartik Narayanan on 15/03/22.
    //

import Foundation
import UIKit


struct Board {
    var tiles: [Tile]
    
    init() {
        tiles = [Tile]()
        resetBoard()
    }
    
    mutating func resetBoard() {
        tiles = [Tile]()
        for i in stride(from: Limits.boardSize, to: Limits.boardSize - (Limits.boardSize/Limits.boardLength), by: -1) {
            tiles.append(Tile(tId: i, tOccupiedBy: [], tSnakeOrLadder: (tileType.none, -1)))
        }
        var start = 0
        var end = start + (Limits.boardSize/Limits.boardLength)
        for _ in 1...Limits.boardLength {
            var tmpId = [Int]()
            for i in start...end-1  {
                tmpId.append(tiles[i].tId - Limits.boardLength)
                print(tmpId)
            }
            tmpId = tmpId.reversed()
            for i in 0...Limits.boardLength - 1{
                tiles.append(Tile(tId: tmpId[i], tOccupiedBy: [], tSnakeOrLadder: (tileType.none, -1)))
            }
            start = end
            end = start + (Limits.boardSize/Limits.boardLength)
        }
        print(tiles)
    }
    
    func getTileInfo(index: Int) -> Tile {
        return tiles[index]
    }
}







