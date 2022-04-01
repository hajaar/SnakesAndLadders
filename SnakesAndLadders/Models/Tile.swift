    //
    //  Tile.swift
    //  SnakesAndLadders
    //
    //  Created by Kartik Narayanan on 17/03/22.
    //

import Foundation
import UIKit

struct Tile {
    var tId: Int = 0 //shows the number of tile on the board
    var tIndex: Int = AppConfig.tileStartId //index of the tile in the array created by Board
    var tOccupiedBy: [Bool] = [Bool](repeating: false, count: AppConfig.numberofPlayers) {
        didSet {
            Log.log("tileID: \(tId) contains \(tOccupiedBy)", level: .trace)
        }
    }
    var tSnakeOrLadder: (status: tileType, terminus: Int) = (tileType.none, -1) {
        didSet {
            Log.log("tileID: \(tId) contains \(tSnakeOrLadder.status) ending at \(tSnakeOrLadder.terminus )" , level: .debug)
        }
    }
    var tColor: UIColor {
        self.tId.isMultiple(of: 2) ? AppConfig.tileColor.0 : AppConfig.tileColor.1
    }
    var tTextColor: UIColor {
        self.tId.isMultiple(of: 2) ? AppConfig.boardTextColor.0 : AppConfig.boardTextColor.1
    }
    var tBorderColor: UIColor {
        self.tId.isMultiple(of: 2) ? AppConfig.tileColor.1 : AppConfig.tileColor.0
    }
    
    var tSnakeOrLadderImage: (symbol: UIImage?, symbolColor: UIColor) {
        var tmpString: String = ""
        var tmpColor: UIColor = AppConfig.diceColor
        
            switch tSnakeOrLadder.status {
            case .ladderStart:
                tmpString = symbolNames.ladderStart
                tmpColor = AppConfig.ladderColor
            case .ladderEnd:
                tmpString = symbolNames.ladderEnd
                tmpColor = AppConfig.ladderColor
            case .snakeStart:
                tmpString = symbolNames.snakeStart
                tmpColor = AppConfig.snakeColor
            case .snakeEnd:
                tmpString = symbolNames.snakeEnd
                
            default:
                tmpString = ""
            }

        return (UIImage(systemName: tmpString),tmpColor)
    }
    
    var tPlayerImages: [UIImage?] {
        var playerImages = [UIImage](repeating: UIImage(), count: AppConfig.numberofPlayers)
        for i in 0...AppConfig.numberofPlayers - 1 {
            playerImages[i] = tOccupiedBy[i] ? UIImage(systemName:  String(i) + symbolNames.playerName)! : UIImage()
        }
        return playerImages
    }
    
    init(tId: Int, tSnakeOrLadder: (status: tileType, terminus: Int)) {
        self.tId = tId
        self.tSnakeOrLadder.status = tSnakeOrLadder.status
        self.tSnakeOrLadder.terminus = tSnakeOrLadder.terminus
        AppConfig.tileStartId += 1
    }
    
    mutating func addPlayer(playerId: Int){
        tOccupiedBy[playerId] = true
        Log.log("player \(playerId) is at tileId: \(tId) \(tOccupiedBy) ", level: .trace)
    }
    
    mutating func removePlayer(playerId: Int){
        tOccupiedBy[playerId] = false
        Log.log("player \(playerId) removed from tileId: \(tId) \(tOccupiedBy) ", level: .trace)
    }
}
