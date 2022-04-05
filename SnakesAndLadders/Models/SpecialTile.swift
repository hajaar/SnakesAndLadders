//
//  SnakeAndLadder.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 17/03/22.
//

import Foundation
import UIKit

struct SpecialTile {

    private var tileType: TileType
    private var length: lengthSnakeAndLadder
    private var start: Int //position
    private var end: Int {
        try! BoardHelper.returnEndingPosition(tileType: tileType, start: start, length: length)
    }
    private var index: Int //position in array
    private var tileId: Int { //tileIndex corresponding to indexpath.row
        BoardHelper.getTileIndexFromId(start)
    }

    private var specialTileSymbol: (symbol: UIImage, symbolColor: UIColor) {
        var tmpString: String = ""
        var tmpColor: UIColor = AppDesign.diceColor
        
        switch tileType {
        case .snake:
            tmpString = symbolNames.snake
            tmpColor = AppDesign.snakeColor
        case .ladder:
            tmpString = symbolNames.ladder
            tmpColor = AppDesign.ladderColor
        case .slow:
            tmpString = symbolNames.slow
            tmpColor = AppDesign.snakeColor
        case .fast:
            tmpString = symbolNames.fast
            tmpColor = AppDesign.ladderColor
        case .normal:
            tmpString = ""
            tmpColor = AppDesign.ladderColor
        }
        
        return (UIImage(systemName: tmpString)!,tmpColor)
    }
    
    init(index: Int, start: Int, length: lengthSnakeAndLadder, tileType: TileType ) {
        self.tileType = tileType
        self.length = tileType == .slow || tileType == .fast ? .E : length
        self.start = start
        self.index = index
        Log.log("tiletype: \(tileType) start: \(start) end: \(self.end) length: \(length.length)", level: .debug)
    }
    
    func getStart() -> Int{
        return start
    }
    
    func getEnd() -> Int{
        return end
    }
    
    func getSymbolImage() -> (UIImage, UIColor) {
        Log.log("\(start)", level: .trace)
        return specialTileSymbol
    }

    func getTileType() -> TileType {
        return tileType
    }
}
