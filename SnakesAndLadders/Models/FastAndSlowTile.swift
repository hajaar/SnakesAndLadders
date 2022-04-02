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
        let isSlow = Bool.random()
        var tileId = Int.random(in: 2...AppConfig.boardSize - 1)
        while areConstraintsViolated(start: tileId) {
            tileId = Int.random(in: 2...AppConfig.boardSize - 1)
        }
        return (tileId: tileId, isSlow: isSlow)
    }
    
    static var mapIdToIndex = [Int: Int]()
    
    static func getIdFromIndex(value: Int) -> Int {
        let keys = (Self.mapIdToIndex as NSDictionary).allKeys(for: value) as! [Int]
        return keys[0]
    }
    
    static func getIndexFromId(_ tileId: Int) -> Int {
        return FastAndSlowTile.mapIdToIndex[tileId] ?? -1
    }
    
    static func areConstraintsViolated(start: Int) -> Bool {
        return FastAndSlowTile.getIndexFromId(start) != -1 ? true : false
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
