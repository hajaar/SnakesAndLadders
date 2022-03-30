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
    static var startId = -1
    static let boardTextColor = (IndianColors.ShipsOfficer, IndianColors.HoneyGlow)
    static let boardColor = IndianColors.Keppel
    static let highlightTileColor = IndianColors.HighlighterLavender
    static let tileColor = (IndianColors.SpiroDiscoBall, IndianColors.EndingNavyBlue)
    static let diceColor = UIColor.black
    
    
}


struct symbolNames {
    static let ladderStart: String = "arrowtriangle.up"
    static let ladderEnd: String = "stop.circle"
    static let snakeStart: String = "arrowtriangle.down"
    static let snakeEnd: String = "stop.circle"
    static let playerName: String = ".circle.fill"
    static let tileName: String = ".square"
}


enum tileOccupiedStatus {
    case unoccupied, player1, player2
}

enum  tileType {
    case snakeStart, snakeEnd, ladderStart, ladderEnd, none
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



