//
//  GameSession.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 17/03/22.
//

import Foundation

struct GameSession {
    private var board: Board
    private var players: [Player]
    
    init() {
        board = Board()
        players = [Player]()
        for i in 1...Limits.numberofPlayers {
            players.append(Player(name: String(i), token: String(i))) //add function to get player input and pass it here
        }
    }
    
    func getBoard() -> Board {
        return board
    }
    
    
    
    private mutating func newBoard() {
        board.resetBoard()
    }
}
