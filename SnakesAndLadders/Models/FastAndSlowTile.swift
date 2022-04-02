//
//  FastAndSlow.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 02/04/22.
//

import Foundation
import UIKit


struct FastAndSlowTile {
    static func generateRandomFastOrSlowTile() -> (tileId: Int, isSlow: Bool){
        var tileId: Int = 1
        var isSlow: Bool = true
        return (tileId: tileId, isSlow: isSlow)
    }

    private var isSlow: Bool
    private var tileId: Int
    private var index: Int
    
    init(index: Int, tileId: Int, isSlow: Bool) {
        self.index = index
        self.tileId = tileId
        self.isSlow = isSlow
    }
}
