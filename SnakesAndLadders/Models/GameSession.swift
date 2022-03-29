//
//  GameSession.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 17/03/22.
//

import Foundation
import UIKit

struct GameSession {
    private var board: Board
    private var players: [Player]
    
    init() {
        
        players = [Player]()
        board = Board()

    }
    
    private mutating func createPlayers(name: String, token: String) {
        for i in 1...AppConfig.numberofPlayers {
            players.append(Player(playerID: i, name: name, token: token)) //add function to get player input and pass it here
        }
    }
    
    func getTileInfo(index: Int) -> Tile {
        return board.getTileInfo(index: index)
        
    }
    
    mutating func newBoard(players: [Player]) {
        board.startNewGame(players: players)

    }
    
    func playTurn() -> (Int, [UIImage], UIImage) {
        Dice.roll()
        return (Dice.returnRollSum(), Dice.animateSingleDieRoll(),Dice.returnFirstRollSymbol())
    }
}
