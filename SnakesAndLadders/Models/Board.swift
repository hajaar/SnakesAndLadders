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
        }
        //print(tiles)
    }
    
}
	
struct Tile {
    var tId: Int = 0
    var tOccupiedBy: [String] = []
    var tSnakeOrLadder: (status: tileType, terminus: Int) = (tileType.none, -1)
    var tColor: UIColor {
        self.tId.isMultiple(of: 2) ? Colors.tileColor.0 : Colors.tileColor.1
    }
    var tImage: UIImage? {
        var tmpString: String = ""
        if tOccupiedBy.isEmpty {
            if tSnakeOrLadder.status != .none {
                tmpString = tSnakeOrLadder.status == .ladder ? Names.ladderStart : Names.snakeStart
            }
        } else {
            tmpString = tOccupiedBy.last! + Names.playerName
        }
        return UIImage(systemName: tmpString)
    }

}



