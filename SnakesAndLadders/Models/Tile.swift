//
//  Tile.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 17/03/22.
//

import Foundation
import UIKit

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
