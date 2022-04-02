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

    init(tId: Int, tIndex: Int = 0) {
        self.tId = tId
        self.tIndex = tIndex
    }
    
    var tColor: UIColor {
        self.tId.isMultiple(of: 2) ? AppDesign.tileColor.0 : AppDesign.tileColor.1
    }
    var tTextColor: UIColor {
        self.tId.isMultiple(of: 2) ? AppDesign.boardTextColor.0 : AppDesign.boardTextColor.1
    }
    var tBorderColor: UIColor {
        AppDesign.tileBorderColor
    }
    


}
