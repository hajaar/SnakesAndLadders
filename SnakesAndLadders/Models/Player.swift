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

    private var position: Int = 1 {
        didSet {
            Log.log("playerId \(playerId) moved from \(oldValue) to \(position) ", level: .debug)
        }
    } // position is based on tId and not index.
    private var balance: Int = 0 {
        didSet {
            Log.log("playerId \(playerId) balance changed from \(oldValue) to \(balance) ", level: .trace)
        }
    }
    private var createdSnakesAndLadders: [SnakeAndLadder] = []
    private var wins: Int = 0
    private var remainingSnakesAndLaddersOptions: [lengthSnakeAndLadder] = [.small, .medium, .large, .extraLarge]
    
    init(playerID: Int, name: String, token: String) {
        self.playerId = playerID
        self.name = name
        self.token = token

        Log.log("\(self.playerId) \(self.name) \(self.token)", level: .debug)
        
        position = 1
        balance = 0
        createdSnakesAndLadders = []
        remainingSnakesAndLaddersOptions = [.small, .medium, .large, .extraLarge]
        
        Log.log("player: \(playerId) position: \(position) balance: \(balance)", level: .trace)
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
    
    func getPosition() -> Int {
        return position
    }
    
    mutating func setPosition(position: Int) {
        self.position = position
    }
    
    func getId() -> Int {
        return playerId
    }
}


