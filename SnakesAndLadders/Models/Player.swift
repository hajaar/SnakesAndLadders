    //
    //  Player.swift
    //  SnakesAndLadders
    //
    //  Created by Kartik Narayanan on 17/03/22.
    //

import Foundation
import UIKit

struct Player {
    private var playerId: Int
    private var name: String = ""
    private var token: String = ""

    private var balance: Int = 0 {
        didSet {
            Log.log("playerId \(playerId) balance changed from \(oldValue) to \(balance) ", level: .trace)
        }
    }
    private var createdSnakesAndLadders: [SnakeAndLadder] = []
    private var wins: Int = 0
    private var remainingSnakesAndLaddersOptions: [lengthSnakeAndLadder] = [.small, .medium, .large, .extraLarge]

    private var nextTurnType: TurnType = .normal
    
    
    init(playerID: Int, name: String, token: String) {
        self.playerId = playerID
        self.name = name
        self.token = token

        Log.log("\(self.playerId) \(self.name) \(self.token)", level: .debug)

        balance = 0
        createdSnakesAndLadders = []
        remainingSnakesAndLaddersOptions = [.small, .medium, .large, .extraLarge]
        
        Log.log("player: \(playerId) balance: \(balance)", level: .trace)
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

    func getId() -> Int {
        return playerId
    }
    
    func getNextTurnType() -> TurnType {
        return nextTurnType
    }
    
    mutating func setNextTurnType(turnType: TurnType) {
        self.nextTurnType = turnType
    }
    
    mutating func nextTurnValue(roll: Int) -> Int {
        var modifiedRoll = roll
        switch nextTurnType {
        case .normal:
            modifiedRoll = roll
        case .slow:
            modifiedRoll = roll/2
        case .fast:
            modifiedRoll = roll * 2
        }
        nextTurnType = .normal
        return modifiedRoll
    }
    
}


