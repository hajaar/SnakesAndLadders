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
    

    
    static func areConstraintsViolated(start: Int) -> Bool {
        return Board.getIndexFromId(start) != -1 ? true : false
    }


    private var isSlow: Bool
    private var tileId: Int
    private var index: Int
    
    private var symbolOfFastAndSlowTile: (symbol: UIImage, symbolColor: UIColor) {
        var tmpString: String = ""
        var tmpColor: UIColor = AppDesign.diceColor
        
        if isSlow {
            
            tmpString = symbolNames.slow
            tmpColor = AppDesign.snakeColor
            
        }   else {
            tmpString = symbolNames.fast
            tmpColor = AppDesign.ladderColor
        }
        return (UIImage(systemName: tmpString)!,tmpColor)
    }
    
    
    init(index: Int, tileId: Int, isSlow: Bool) {
        self.index = index
        self.tileId = tileId
        self.isSlow = isSlow
        Log.log("tileId: \(tileId) isSlow: \(isSlow)", level: .debug)
    }
    
    func getStart() -> Int {
        return tileId
    }
    
    func getSymbolImage() -> (UIImage, UIColor) {
        return symbolOfFastAndSlowTile
    }
    
}
