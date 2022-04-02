    //
    //  K.swift
    //  SnakesAndLadders
    //
    //  Created by Kartik Narayanan on 16/03/22.
    //

import Foundation
import UIKit

struct AppConfig {
    static let boardLength = 10
    static let boardSize = boardLength * boardLength
    static let numberofPlayers = 4
}


struct AppDesign {
    
    static let boardTextColor = (FlatColors.Clouds, IndianColors.SarawakWhitePepper)
    static let boardColor = FlatColors.GreenSea
    static let highlightTileColor = IndianColors.HighlighterLavender
    static let tileColor = (FlatColors.MidnightBlue, IndianColors.EndingNavyBlue)
    static let diceColor = UIColor.black
    static let ladderColor = FlatColors.Emerald
    static let snakeColor = FlatColors.Alizarin
    static var playerColors = [IndianColors.FallingStar, FlatColors.Turquoise, IndianColors.HoneyGlow, IndianColors.GeorgiaPeach, IndianColors.ClearChill, FlatColors.Emerald]
    
    static func returnRandomPlayerColor() -> UIColor {
        let i = Int.random(in: 0...playerColors.count-1)
        let playerColor = playerColors[i]
        playerColors.remove(at: i)
        return playerColor
    }
    
    
}

struct symbolNames {
    static let ladderStart: String = "arrowtriangle.up.fill"
    static let snakeStart: String = "arrowtriangle.down.fill"
    static let playerName: String = ".circle.fill"
    static let tileName: String = ".square"
    static let fastTile: String = "hare.fill"
    static let slowTile: String = "tortoise.fill"
}


enum  tileType {
    case snakeStart, fastStart, ladderStart, slowStart, none
}

enum TurnType {
    case normal, slow, fast
}

enum lengthSnakeAndLadder: Int, CaseIterable {
    case small, medium, large, extraLarge
    
    var value: Int {
        switch self {
        case .small:
            return 5
        case .medium:
            return 10
        case .large:
            return 20
        case .extraLarge:
            return 40
        }
    }
}




