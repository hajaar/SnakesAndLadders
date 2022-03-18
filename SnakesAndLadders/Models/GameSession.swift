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
        board = Board()
        players = [Player]()
        for _ in 1...Limits.numberofPlayers {
            players.append(Player()) //add function to get player input and pass it here
        }
    }
    
    func getTileInfo(index: Int) -> Tile {
        return board.getTileInfo(index: index)
        
    }
    
    private mutating func newBoard() {
        board.resetBoard()
        for i in 1...Limits.numberofPlayers {
            players[i].startNewGame()
        }
    }
    
    func playTurn() -> (Int, [UIImage], UIImage) {
        Dice.roll()
        return (Dice.returnRollSum(), Dice.animateSingleDieRoll(),Dice.returnFirstRollSymbol())
    }
}
