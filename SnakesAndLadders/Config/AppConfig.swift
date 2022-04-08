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
     //   playerColors.remove(at: i)
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
    case snake, ladder, slow, fast, normal

    var turnSpeed: Double {
        switch self {
        case .normal, .ladder, .snake:
            return 1.0
        case .slow:
            return 0.5
        case .fast:
            return 2.0
        }
    }

    var earningMultipler: Double {
        switch self {
        case .snake:
            return 2.0
        case .ladder:
            return 0.5
        case .slow:
            return 2.0
        case .fast:
            return 0.5
        case .normal:
            return 1.0
        }
    }


}

enum lengthSnakeAndLadder: Int, CaseIterable {
    case E, S, M, L, XL
    
    var length: Int {
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

    var cost: Int {
        switch self {
        case .E:
            return 0
        case .S:
            return Int(Double(self.length) * 3.0)
        case .M:
            return Int(Double(self.length) * 2.0)
        case .L:
            return Int(Double(self.length) * 1.5)
        case .XL:
            return Int(Double(self.length) * 1.0)
        }
    }

    var name: String {
        switch self {
        case .E:
            return "Empty"
        case .S:
            return "Small"
        case .M:
            return "Medium"
        case .L:
            return "Large"
        case .XL:
            return "Extra-large"
        }
    }
}

enum BoardError: Error {
    case exceedsBoardSize, specialTile
}



