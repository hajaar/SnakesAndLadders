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
    static var tileStartId = 0
    static let boardTextColor = (FlatColors.Clouds, IndianColors.SarawakWhitePepper)
    static let boardColor = FlatColors.GreenSea
    static let highlightTileColor = IndianColors.HighlighterLavender
    static let tileColor = (FlatColors.BelizeHole, IndianColors.EndingNavyBlue)
    static let diceColor = UIColor.black
    static let ladderColor = FlatColors.Emerald
    static let snakeColor = FlatColors.Alizarin
    static let playerColors = [IndianColors.FallingStar, FlatColors.Turquoise, IndianColors.HoneyGlow, IndianColors.GeorgiaPeach]
}


struct symbolNames {
    static let ladderStart: String = "capsule.portrait.fill"
    static let snakeStart: String = "capsule.portrait.fill"
    static let playerName: String = ".circle.fill"
    static let tileName: String = ".square"
    static let fastTile: String = "hare.fill"
    static let slowTile: String = "tortoise.fill"
}


enum  tileType {
    case snakeStart, fastStart, ladderStart, slowStart, none
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



