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
            switch tSnakeOrLadder.status {
            case .ladderStart:
                tmpString = Names.ladderStart
            case .ladderEnd:
                tmpString = Names.ladderEnd
            case .snakeStart:
                tmpString = Names.snakeStart
            case .snakeEnd:
                tmpString = Names.snakeEnd
            default:
                tmpString = ""
            }
        } else {
            tmpString = tOccupiedBy.last! + Names.playerName
        }
        return UIImage(systemName: tmpString)
    }

}



