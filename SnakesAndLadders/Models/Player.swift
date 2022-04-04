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

    func getIsHuman() -> Bool {
        return isHuman
    }

    mutating func setHuman(isHuman: Bool) {
        self.isHuman = isHuman
    }

    mutating func nextTurnValue(roll: Int) -> Int {
        let modifiedRoll = roll * nextTurnType.value
        nextTurnType = .normal
        return modifiedRoll
    }

    mutating func playerRollsDice() -> Int{
        Log.log(playerId, level: .trace)
        Dice.roll()
        let roll = Dice.returnRollSum()
        var newPosition = position + nextTurnValue(roll: roll)
        if newPosition > AppConfig.boardSize || newPosition < 1 {
            newPosition = position
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

