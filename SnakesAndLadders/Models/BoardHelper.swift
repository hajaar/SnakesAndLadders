//
//  BoardHelper.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 03/04/22.
//

import Foundation

struct BoardHelper {
     static var tileLookup = [Int: Int]() //has position and tileId
     static var specialTileLookup = [Int: Int]() //has position and index. Use tileLookup to get tileid given position
    
    static func getTileIdFromIndex(value: Int) -> Int {
        let keys = (tileLookup as NSDictionary).allKeys(for: value) as! [Int]
        return keys[0]
    }
    
    static func getTileIndexFromId(_ tileId: Int) -> Int {
        return tileLookup[tileId] ?? -1
    }
    
    static func getSpecialTileIndexFromId(_ tileId: Int) -> Int {
        return Self.specialTileLookup[tileId] ?? -1
    }



    
    static func resetBoard()  {
        var arr = [Int]()
        tileLookup.removeAll()
        specialTileLookup.removeAll()
        for i in stride(from: AppConfig.boardSize, to: AppConfig.boardSize - (AppConfig.boardSize / AppConfig.boardLength), by: -1) {
            arr.append((i))
        }
        var start = 0
        var end = start + (AppConfig.boardSize / AppConfig.boardLength)
        for _ in 1...AppConfig.boardLength {
            var tmpId = [Int]()
            for i in start...end - 1 {

                tmpId.append(arr[i] - AppConfig.boardLength)
                
            }
            tmpId = tmpId.reversed()
            for i in 0...AppConfig.boardLength - 1 {
                arr.append(tmpId[i])
            }
            start = end
            end = start + (AppConfig.boardSize / AppConfig.boardLength)
        }
        for i in 0...AppConfig.boardSize - 1 {
            tileLookup[arr[i]] = i
        }
    }

    static  func returnEndingPosition(tileType: TileType, start: Int, length: lengthSnakeAndLadder) throws -> Int {
        var endingPosition = start
        switch tileType {
        case .fast, .slow, .normal:
            return endingPosition
        case .snake:
            endingPosition = start - length.length
            if endingPosition <= 1 {
                throw BoardError.exceedsBoardSize
            }
            return endingPosition
        case .ladder:
            endingPosition = start + length.length
            if endingPosition >= AppConfig.boardSize {
                throw BoardError.exceedsBoardSize
            }
            return endingPosition
        }
    }

    static private func areConstraintsViolated(tileType: TileType, start: Int, length: lengthSnakeAndLadder) -> Bool {
        var endingPosition = start
        if BoardHelper.getSpecialTileIndexFromId(start) != -1  {
            return true
        }
        do {
            endingPosition = try returnEndingPosition(tileType: tileType, start: start, length: length)
            if BoardHelper.getSpecialTileIndexFromId(endingPosition) != -1 {
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
        while BoardHelper.areConstraintsViolated(tileType: tileType, start: start, length: length) {
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

    static func showAllowedLengthsBasedOnPosition(pos: Int, type: TileType) -> [lengthSnakeAndLadder]? {
        var allowedLengths = [lengthSnakeAndLadder]()
        let bound = type == TileType.snake ? AppConfig.boardSize - 1 - pos : pos
        switch bound {
        case lengthSnakeAndLadder.XL.length... :
            allowedLengths.append(.XL)
            fallthrough
        case lengthSnakeAndLadder.L.length..<lengthSnakeAndLadder.XL.cost:
            allowedLengths.append(.L)
            fallthrough
        case lengthSnakeAndLadder.M.length..<lengthSnakeAndLadder.L.cost:
            allowedLengths.append(.M)
            fallthrough
        case lengthSnakeAndLadder.S.length..<lengthSnakeAndLadder.M.cost:
            allowedLengths.append(.S)
        case ..<lengthSnakeAndLadder.S.length:
            return nil
        default:
            return nil
        }
        return allowedLengths
    }

}
