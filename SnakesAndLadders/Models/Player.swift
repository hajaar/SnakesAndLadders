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
    private var isHuman: Bool = true
    
    private var playerImage: UIImage {
        UIImage(systemName: "\(playerId)\(symbolNames.playerName)")!
    }
    
    private var playerColor: UIColor
    
    private var balance: Int = 0 {
        didSet {
            Log.log("playerId \(playerId) balance changed from \(oldValue) to \(balance) ", level: .trace)
        }
    }
    private var createdSnakesAndLadders: [SpecialTile] = []
    private var wins: Int = 0
    private var remainingSnakesAndLaddersOptions: [lengthSnakeAndLadder] = [.S, .M, .L, .XL]
    
    private var nextTurnType: TurnType = .normal
    
    
    init(playerID: Int, name: String, token: String, isHuman: Bool = true) {
        self.playerId = playerID
        self.name = name
        self.token = token
        self.isHuman = isHuman
        
        self.playerColor = AppDesign.returnRandomPlayerColor()
        
        Log.log("\(self.playerId) \(self.name) \(self.token)", level: .debug)
        
        balance = 0
        createdSnakesAndLadders = []
        remainingSnakesAndLaddersOptions = [.S, .M, .L, .XL]
        
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
    
    mutating func ifPlayerHasComeToSpecialTile(status: TileType, terminus: Int) -> Int {
        var value = -1
        switch status {
        case .snake:
            value = terminus
            position = terminus
        case .fast:
            setNextTurnType(turnType: .fast)
        case .ladder:
            value = terminus
            position = terminus
        case .slow:
            setNextTurnType(turnType: .slow)
        case .normal:
            value = -1
        }
        Log.log("playerid: \(playerId) status: \(status) terminus: \(terminus) value: \(value)", level: .debug)
        return value 
    }
    
}

