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
        for i in stride(from: Limits.boardSize, to: 0, by: -1) {
            tiles.append(Tile(tId: i, tOccupiedBy: [], tSnakeOrLadder: (tileType.none, -1)))
        }
        print(tiles)
    }
}







