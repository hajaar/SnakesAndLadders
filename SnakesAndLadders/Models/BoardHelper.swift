//
//  BoardHelper.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 03/04/22.
//

import Foundation

struct BoardHelper {
     static var tileLookup = [Int: Int]()
     static var specialTileLookup = [Int: Int]()
    
    static func getTileIdFromIndex(value: Int) -> Int {
        let keys = (tileLookup as NSDictionary).allKeys(for: value) as! [Int]
        return keys[0]
    }
    
    static func getTileIndexFromId(_ tileId: Int) -> Int {
        return tileLookup[tileId] ?? -1
    }
    
    static func getSpecialTileIdFromIndex(value: Int)  -> Int {
        let keys = (Self.specialTileLookup as NSDictionary).allKeys(for: value) as! [Int]
        return keys[0]
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
}
