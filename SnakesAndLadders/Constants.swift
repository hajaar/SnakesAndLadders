    //
    //  K.swift
    //  SnakesAndLadders
    //
    //  Created by Kartik Narayanan on 16/03/22.
    //

import Foundation
import UIKit


struct Colors {
    private static let mattPurple = UIColor(red: 0.55, green: 0.48, blue: 0.90, alpha: 1.00)
    private static let skirretGreen = UIColor(red: 0.27, green: 0.74, blue: 0.20, alpha: 1.00)
    private static let nanohanachaGold = UIColor(red: 0.88, green: 0.69, blue: 0.17, alpha: 1.00)
    private static let darkBlue = UIColor(red: 0.08, green: 0.45, blue: 0.63, alpha: 1.00)
    private static let lightBlue = UIColor(red: 0.60, green: 0.82, blue: 0.93, alpha: 1.00)
    static let boardTextColor = UIColor.black
    static let boardColor = skirretGreen
    static let highlightTileColor = nanohanachaGold
    static let tileColor = (lightBlue, darkBlue)
}

struct symbolNames {
    static let ladderStart: String = "arrowtriangle.up"
    static let ladderEnd: String = "stop.circle"
    static let snakeStart: String = "arrowtriangle.down"
    static let snakeEnd: String = "stop.circle"
    static let playerName: String = ".book.closed"
    static let tileName: String = ".square"
}

struct Limits {
    static let boardLength = 10
    static let boardSize = boardLength * boardLength
    static let numberofPlayers = 2
    static var startId = -1
}


enum tileOccupiedStatus {
    case unoccupied, player1, player2
}

enum  tileType {
    case snakeStart, snakeEnd, ladderStart, ladderEnd, none
}

enum lengthSnakeAndLadder: Int {
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



