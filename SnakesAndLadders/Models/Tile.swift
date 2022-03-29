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
    var tOccupiedBy: [Int] = []
    var tSnakeOrLadder: (status: tileType, terminus: Int) = (tileType.none, -1)
    var tColor: UIColor {
        self.tId.isMultiple(of: 2) ? AppConfig.tileColor.0 : AppConfig.tileColor.1
    }
    var tTextColor: UIColor {
        self.tId.isMultiple(of: 2) ? AppConfig.boardTextColor.0 : AppConfig.boardTextColor.1
    }
    var tBorderColor: UIColor {
        self.tId.isMultiple(of: 2) ? AppConfig.tileColor.1 : AppConfig.tileColor.0
    }
    
    var tImage: UIImage? {
        var tmpString: String = ""
        if tOccupiedBy.isEmpty {
            switch tSnakeOrLadder.status {
            case .ladderStart:
                tmpString = symbolNames.ladderStart
            case .ladderEnd:
                tmpString = symbolNames.ladderEnd
            case .snakeStart:
                tmpString = symbolNames.snakeStart
            case .snakeEnd:
                tmpString = symbolNames.snakeEnd
            default:
                tmpString = ""
            }
        } else {
            tmpString = String(tOccupiedBy.last!) + symbolNames.playerName
        }
        return UIImage(systemName: tmpString)
    }
    
    mutating func addPlayer(playerId: Int){
        tOccupiedBy.append(playerId)
    }
    
    mutating func removePlayer(playerId: Int){
        for i in 0...tOccupiedBy.count - 1 {
            if tOccupiedBy[i] == playerId {
                tOccupiedBy.remove(at: i)
                return
            }
        
        }
        
    }
    
}
