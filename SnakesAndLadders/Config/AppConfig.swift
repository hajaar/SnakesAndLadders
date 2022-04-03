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
    static let tileBorderColor = FlatColors.SunFlower
    static let diceColor = UIColor.black
    static let ladderColor = FlatColors.Emerald
    static let snakeColor = FlatColors.Carrot
    static var playerColors = [IndianColors.FallingStar, IndianColors.SweetGarden, IndianColors.HoneyGlow, IndianColors.OrchidOrange, IndianColors.SpiroDiscoBall, IndianColors.BrightUbe]
    
    static func returnRandomPlayerColor() -> UIColor {
        let i = Int.random(in: 0...playerColors.count-1)
        let playerColor = playerColors[i]
        playerColors.remove(at: i)
        return playerColor
    }
    
    
}

struct symbolNames {
    static let ladder: String = "arrowtriangle.up.fill"
    static let snake: String = "arrowtriangle.down.fill"
    static let playerName: String = ".circle.fill"
    static let tile: String = ".square"
    static let fast: String = "hare.fill"
    static let slow: String = "tortoise.fill"
}


enum  TileType {
    case snake, ladder, slow, fast, normal
}

enum TurnType {
    case normal, slow, fast
}

enum lengthSnakeAndLadder: Int, CaseIterable {
    case E, S, M, L, XL
    
    var value: Int {
        switch self {
        case .E:
            return 0
        case .S:
            return 5
        case .M:
            return 10
        case .L:
            return 20
        case .XL:
            return 40
        }
    }
}

enum BoardError: Error {
    case exceedsBoardSize, specialTile
}



