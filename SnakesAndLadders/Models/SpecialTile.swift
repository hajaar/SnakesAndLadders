//
//  SnakeAndLadder.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 17/03/22.
//

import Foundation
import UIKit

struct SpecialTile {
    static var specialTileLookup = [Int: Int]()
    
    static func getIdFromIndex(value: Int) -> Int {
        let keys = (Self.specialTileLookup as NSDictionary).allKeys(for: value) as! [Int]
        return keys[0]
    }
    
    static func getIndexFromId(_ tileId: Int) -> Int {
        return Self.specialTileLookup[tileId] ?? -1
    }
    
    static private func returnEndingPosition(tileType: TileType, start: Int, length: lengthSnakeAndLadder) throws -> Int {
        var endingPosition = start
        switch tileType {
        case .fast, .slow, .normal:
            return endingPosition
        case .snake:
            endingPosition = start - length.value
            if endingPosition <= 1 {
                throw BoardError.exceedsBoardSize
            }
            return endingPosition
        case .ladder:
            endingPosition = start + length.value
            if endingPosition >= AppConfig.boardSize {
                throw BoardError.exceedsBoardSize
            }
            return endingPosition
        }
    }

    static private func areConstraintsViolated(tileType: TileType, start: Int, length: lengthSnakeAndLadder) -> Bool {
        var endingPosition = start
        if Self.getIndexFromId(start) != -1  {
            return true
        }
        do {
            endingPosition = try SpecialTile.returnEndingPosition(tileType: tileType, start: start, length: length)
            if Self.getIndexFromId(endingPosition) != -1 {
                return true
            }
            return false
        } catch {
            return true
        }
    }
    
    static func generateSpecialTile(tileType: TileType) -> (start: Int, length: lengthSnakeAndLadder) {
        var start = Int.random(in: 2...AppConfig.boardSize - 1)
        var length = returnRandomLengthForSpecialTile(tileType: tileType)
        while SpecialTile.areConstraintsViolated(tileType: tileType, start: start, length: length) {
            start = Int.random(in: 2...AppConfig.boardSize - 1)
            length = returnRandomLengthForSpecialTile(tileType: tileType)
        }
        return (start: start, length: length)
    }
    
    static private func returnRandomLengthForSpecialTile(tileType: TileType) -> lengthSnakeAndLadder {
        switch tileType {
        case .snake, .ladder:
            var l = lengthSnakeAndLadder.allCases.randomElement()
            while l == .E {
                l = lengthSnakeAndLadder.allCases.randomElement()
            }
            return l!
        case .slow, .fast, .normal:
            return .E
        }
    }
    
    
    private var tileType: TileType
    private var length: lengthSnakeAndLadder
    private var start: Int //position
    private var end: Int {
        switch tileType {
        case .snake:
            return start - length.value
        case .ladder:
            return start + length.value
        case .slow, .fast, .normal:
            return start
        }
    }
    private var index: Int
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
        self.length = length
        self.start = start
        self.index = index
        Log.log("tiletype: \(tileType) start: \(start) end: \(self.end) length: \(length.value)", level: .debug)
    }
    
    func getStart() -> Int{
        return start
    }
    
    func getEnd() -> Int{
        return end
    }
    
    func getSymbolImage() -> (UIImage, UIColor) {
        return specialTileSymbol
    }
}
