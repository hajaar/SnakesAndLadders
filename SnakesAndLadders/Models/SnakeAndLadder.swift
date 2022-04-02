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
    
    static var mapIdToIndex = [Int: Int]()
    
    static func getIdFromIndex(value: Int) -> Int {
        let keys = (Self.mapIdToIndex as NSDictionary).allKeys(for: value) as! [Int]
        return keys[0]
    }
    
    static func getIndexFromId(_ tileId: Int) -> Int {
        return SnakeAndLadder.mapIdToIndex[tileId] ?? -1
    }
    
    private var isSnake: Bool
    private var length: lengthSnakeAndLadder
    private var start: Int //position
    private var end: Int {
        return start + (isSnake ? -1 : 1) * length.value
    }
    private var index: Int
    private var symbolOfSnakeAndLadder: (symbol: UIImage, symbolColor: UIColor) {
        var tmpString: String = ""
        var tmpColor: UIColor = AppDesign.diceColor
        
        if isSnake {

            tmpString = symbolNames.snake
            tmpColor = AppDesign.snakeColor

        }   else {
                tmpString = symbolNames.ladder
                tmpColor = AppDesign.ladderColor
            }
        return (UIImage(systemName: tmpString)!,tmpColor)
    }
    
    init(index: Int, start: Int, length: lengthSnakeAndLadder, isSnake: Bool ) {
        self.isSnake = isSnake
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
