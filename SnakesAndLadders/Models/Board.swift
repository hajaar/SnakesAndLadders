//
//  Board.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 15/03/22.
//

import Foundation
import UIKit


struct Board {
    var tiles: [Tile] = [Tile](repeating: Tile(), count: Limits.boardSize)
    
    init() {
        resetBoard()
    }
    
    mutating func resetBoard() {
        for i in 0...tiles.count - 1 {
            tiles[i].tId = i
            tiles[i].tOccupiedBy = []
            tiles[i].tSnakeOrLadder = (tileType.none, -1)
        }
        print(tiles)
        tiles[1].tSnakeOrLadder.status = .ladderStart
        tiles[2].tSnakeOrLadder.status = .snakeStart
        tiles[3].tSnakeOrLadder.status = .ladderEnd
        tiles[4].tSnakeOrLadder.status = .snakeEnd
    }
    
}
	



