//
//  SnakeAndLadder.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 17/03/22.
//

import Foundation
import UIKit

struct SnakeAndLadder {
    static func returnEndingPosition(tileType: TileType, start: Int, length: lengthSnakeAndLadder) throws -> Int {
        var endingPosition = 0
        switch tileType {
        case .fast, .slow, .normal:
            endingPosition = start
        case .snake:
            endingPosition = start - length.value
            if endingPosition <= 1 {
                throw BoardError.exceedsBoardSize
            }
        case .ladder:
            endingPosition = start + length.value
            if endingPosition >= AppConfig.boardSize {
                throw BoardError.exceedsBoardSize
            }
        }
        return endingPosition
    }
    
    

    
    static func areConstraintsViolated(tileType: TileType, start: Int, length: lengthSnakeAndLadder) -> (valid: Bool, endingPosition: Int) {
        var endingPosition = 0
        if Board.getIndexFromId(start) != -1  {
            return (true, endingPosition)
        }
        do {
            endingPosition = try SnakeAndLadder.returnEndingPosition(tileType: tileType, start: start, length: length)
            if Board.getIndexFromId(endingPosition) != -1 {
                return (true, endingPosition)
            }
            return (false, endingPosition)
        } catch {
            return (true, endingPosition)
        }
    }
    
    static func generateRandomSnakeOrLadder() -> (start: Int, length: lengthSnakeAndLadder, tileType: TileType) {
        let tileType = Bool.random() ? TileType.snake : TileType.ladder
        var startingPosition = Int.random(in: 2...AppConfig.boardSize - 1)
        var length = lengthSnakeAndLadder.allCases.randomElement()!
        var value = SnakeAndLadder.areConstraintsViolated(tileType: tileType, start: startingPosition, length: length)
        while value.valid {
            startingPosition = Int.random(in: 2...AppConfig.boardSize - 1)
            length = lengthSnakeAndLadder.allCases.randomElement()!
            value = SnakeAndLadder.areConstraintsViolated(tileType: tileType, start: startingPosition, length: length)
        }
        return (start: startingPosition, length: length, tileType: tileType)
    }
    
    
    private var tileType: TileType
    private var length: lengthSnakeAndLadder
    private var start: Int //position
    private var end: Int {
        return start + (tileType == .snake ? -1 : 1) * length.value
    }
    private var index: Int
    private var symbolOfSnakeAndLadder: (symbol: UIImage, symbolColor: UIColor) {
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
        Log.log("start: \(start) end: \(self.end) length: \(length.value)", level: .debug)
    }
    
    func getStart() -> Int{
        return start
    }
    
    func getEnd() -> Int{
        return end
    }
    
    func getSymbolImage() -> (UIImage, UIColor) {
        return symbolOfSnakeAndLadder
    }
}
