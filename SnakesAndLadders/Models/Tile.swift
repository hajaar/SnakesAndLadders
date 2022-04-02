    //
    //  Tile.swift
    //  SnakesAndLadders
    //
    //  Created by Kartik Narayanan on 17/03/22.
    //

import Foundation
import UIKit

struct Tile {
    static var mapIdToIndex = [Int: Int]()
    
    static func getIdFromIndex(value: Int) -> Int {
        let keys = (Self.mapIdToIndex as NSDictionary).allKeys(for: value) as! [Int]
        return keys[0]
    }
    
    var tId: Int = 0 //shows the number of tile on the board
    var tIndex: Int = 0 //index of the tile in the array created by Board

    var tType: (status: tileType, terminus: Int) = (tileType.none, -1) {
        didSet {
            Log.log("tileID: \(tId) contains \(tType.status) ending at \(tType.terminus )" , level: .debug)
        }
    }
    var tColor: UIColor {
        self.tId.isMultiple(of: 2) ? AppDesign.tileColor.0 : AppDesign.tileColor.1
    }
    var tTextColor: UIColor {
        self.tId.isMultiple(of: 2) ? AppDesign.boardTextColor.0 : AppDesign.boardTextColor.1
    }
    var tBorderColor: UIColor {
        self.tId.isMultiple(of: 2) ? AppDesign.tileColor.1 : AppDesign.tileColor.0
    }
    
    var tTypeImage: (symbol: UIImage?, symbolColor: UIColor) {
        var tmpString: String = ""
        var tmpColor: UIColor = AppDesign.diceColor
        
            switch tType.status {
            case .ladderStart:
                tmpString = symbolNames.ladderStart
                tmpColor = AppDesign.ladderColor
            case .slowStart:
                tmpString = symbolNames.slowTile
                tmpColor = AppDesign.snakeColor
            case .snakeStart:
                tmpString = symbolNames.snakeStart
                tmpColor = AppDesign.snakeColor
            case .fastStart:
                tmpString = symbolNames.fastTile
                tmpColor = AppDesign.ladderColor
                
            default:
                tmpString = ""
            }

        return (UIImage(systemName: tmpString),tmpColor)
    }
    

    
    init(tId: Int, tIndex: Int = 0) {
        self.tId = tId
        self.tIndex = tIndex
    }



}
