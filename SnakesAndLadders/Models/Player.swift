//
//  Player.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 17/03/22.
//

import Foundation

struct Player {
    private var name: String = ""
    private var token: String = ""
    private var position: Int = 0
    private var balance: Int = 0
    private var createdSnakesAndLadders: [SnakeAndLadder] = []
    private var wins: Int = 0
    private var remainingSnakesAndLaddersOptions: [lengthSnakeAndLadder] = [.small, .medium, .large, .extraLarge]
    
    mutating func startNewGame()  {
        position = 0
        balance = 0
        createdSnakesAndLadders = []
        remainingSnakesAndLaddersOptions = [.small, .medium, .large, .extraLarge]
    }
    
    func getBalance() -> Int {
        return balance
    }

    mutating func changeBalance(amount: Int = 0, credit: Bool = true ) -> Int {
        balance += credit ? amount : -1 * amount
        return balance
    }
    
    func checkForAvailableFunds(amount: Int = 0) -> Bool {
        return balance - amount >= 0
    }
    
    
}


