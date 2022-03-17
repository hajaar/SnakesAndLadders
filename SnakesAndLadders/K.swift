//
//  K.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 16/03/22.
//

import Foundation
import UIKit


struct Colors {
    static let tileColor = (UIColor.gray, UIColor.white)
}

struct Names {
    static let ladderStart: String = "arrowtriangle.up"
    static let ladderEnd: String = "stop.circle"
    static let snakeStart: String = "arrowtriangle.down"
    static let snakeEnd: String = "stop.circle"
    static let playerName: String = ".book.closed"
    static let tileName: String = ".square"
}

struct Limits{
    static let boardSize = 100
    static let numberofPlayers = 2
    static var startId = -1
    
}


enum tileOccupiedStatus {
    case unoccupied, player1, player2
}

enum  tileType {
    case snake, ladder, none
}
