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
    private var position: Int = 1
    
    private var playerImage: UIImage {
        UIImage(systemName: "\(playerId)\(symbolNames.playerName)")!
    }
    
    private var playerColor: UIColor
    
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
        
        self.playerColor = AppConfig.playerColors.randomElement()!
        
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
    
    func getName() -> String {
        return name
    }
    
    func getToken() -> String {
        return token
    }
    
    func getPosition() -> Int {
        return position
    }
    
    mutating func setPosition(_ position: Int) {
        self.position = position
    }
    
    func getPlayerImage() -> UIImage {
        return playerImage
    }
    
    func getPlayerColor() -> UIColor {
        return playerColor
    }
    
    mutating func playerRollsDice() -> Int{
        Log.log(playerId, level: .trace)
        let currentPosition = position
        Dice.roll()
        let roll = Dice.returnRollSum()
        let modifiedRoll = nextTurnValue(roll: roll)
        var newPosition = currentPosition + modifiedRoll
        if newPosition > AppConfig.boardSize || newPosition < 1 {
            newPosition = currentPosition
        }
        position = newPosition
        return newPosition
    }
    
    mutating func playerHasComeToSpecialTile(status: tileType, terminus: Int) -> Int {
        var value = -1
        switch status {
        case .snakeStart:
            value = terminus
            position = terminus
        case .fastStart:
            setNextTurnType(turnType: .fast)
        case .ladderStart:
            value = terminus
            position = terminus
        case .slowStart:
            setNextTurnType(turnType: .slow)
        case .none:
            value = -1
        }
        return value 
    }
}

