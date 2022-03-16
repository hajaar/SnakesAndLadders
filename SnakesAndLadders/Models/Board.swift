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
        for i in 1...tiles.count {
            tiles[i - 1].tId = i - 1
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
    var tImage: UIImage {
        var tmpString: String
        if tOccupiedBy.isEmpty {
            switch tSnakeOrLadder.status {
            case .ladder:
                tmpString = Names.ladderStart
            case .snake:
                tmpString = Names.ladderEnd
            default:
                tmpString = String(tId) + Names.tileName
            }
        } else {
            tmpString = tOccupiedBy.last! + Names.playerName
        }
        return UIImage(systemName: tmpString)!
    }

}



