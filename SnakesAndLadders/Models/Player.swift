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
    private var balance: Int = 0
    
    private var playerImage: UIImage {
        UIImage(systemName: "\(playerId)\(symbolNames.playerName)")!
    }
    
    private var playerColor: UIColor
    
    private var nextTurnType: TurnType = .normal
    
    init(playerID: Int, name: String, token: String, isHuman: Bool = true) {
        self.playerId = playerID
        self.name = name
        self.token = token
        self.isHuman = isHuman
        self.playerColor = AppDesign.returnRandomPlayerColor()
        
        Log.log("\(self.playerId) \(self.name) \(self.token)", level: .debug)
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
    
    func getName() -> String {
        return name.isEmpty ? "Player" : name
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

    func getIsHuman() -> Bool {
        return isHuman
    }

    func getBalance() -> Int {
        return balance
    }

    mutating func setBalance(_ balance: Int) {
        self.balance = balance
    }


    mutating func setHuman(isHuman: Bool) {
        self.isHuman = isHuman
    }

    mutating func nextTurnValue(roll: Int) -> Int {
        return Int(Double(roll) * nextTurnType.turnSpeed)

    }

    mutating func playerRollsDice() -> Int{
        Log.log(playerId, level: .trace)
        Dice.roll()
        let roll = Dice.returnRollSum()
        var newPosition = position + nextTurnValue(roll: roll)
        if newPosition > AppConfig.boardSize || newPosition < 1 {
            newPosition = position
        }
        let amount = calculateAmountForTilesMoved(currentPosition: position,
                                                  newPosition: newPosition,
                                                  turnType: nextTurnType)
        Log.log("currentBalance: \(balance) amount: \(amount)", level: .trace)
        updateBalance(amount)


        position = newPosition
        nextTurnType = .normal
        return newPosition
    }
    
    mutating func ifPlayerHasComeToSpecialTile(status: TileType, terminus: Int) -> Int {
        var value = -1
        switch status {
        case .snake, .ladder:
            value = terminus
            let amount = calculateAmountForTilesMoved(currentPosition: position,
                                                      newPosition: terminus,
                                                      turnType: nextTurnType)
            Log.log("currentBalance: \(balance) amount: \(amount)", level: .trace)
            updateBalance(amount)
            position = terminus
        case .fast:
            setNextTurnType(turnType: .fast)
        case .slow:
            setNextTurnType(turnType: .slow)
        case .normal:
            value = -1
        }
        Log.log("playerid: \(playerId) status: \(status) terminus: \(terminus) value: \(value)", level: .debug)
        return value 
    }

    mutating func updateBalance(_ amount: Int) {
        self.balance += amount
        if self.balance < 0 {
            self.balance = 0
        }
    }


    mutating func calculateAmountForTilesMoved(currentPosition: Int, newPosition: Int, turnType: TurnType) -> Int {
        let tilesMoved = newPosition - currentPosition
        return Int(Double(tilesMoved) * turnType.earningMultipler)
    }

    func showAllowedLengthsBasedOnCost() -> [lengthSnakeAndLadder]? {
        var allowedLengths = [lengthSnakeAndLadder]()
        switch balance {
        case lengthSnakeAndLadder.XL.cost... :
            allowedLengths.append(.XL)
            fallthrough
        case lengthSnakeAndLadder.L.cost..<lengthSnakeAndLadder.XL.cost:
            allowedLengths.append(.L)
            fallthrough
        case lengthSnakeAndLadder.M.cost..<lengthSnakeAndLadder.L.cost:
            allowedLengths.append(.M)
            fallthrough
        case lengthSnakeAndLadder.S.cost..<lengthSnakeAndLadder.M.cost:
            allowedLengths.append(.S)
        case ..<lengthSnakeAndLadder.S.cost:
            return nil
        default:
            return nil
        }
        return allowedLengths
    }

    mutating func setName(name: String) {
        self.name = name
    }

 
}

