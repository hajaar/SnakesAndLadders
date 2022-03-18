//
//  Dice.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 18/03/22.
//

import Foundation
import UIKit
struct Dice {
    static private var noOfDice: Int = 1
    static private var noOfSides: Int = 6
    static private var generatedRoll: [Int] = [Int]()
    
    static func create(numberOfDice: Int = 1, numberOfSides: Int = 6) {
        self.noOfDice = numberOfDice
        self.noOfSides = numberOfSides
        roll()
    }
    
    static func roll() {
        generatedRoll = [Int]()
        for _ in 0...noOfDice - 1 {
            generatedRoll.append(Int.random(in: 1...noOfSides))
        }
    }
    
    
    static func returnRollValues() -> [Int] {
        return generatedRoll
    }
    
    static func returnRollSum() -> Int {
        var diceValues = 0
        for i in 0...noOfDice - 1{
            diceValues += generatedRoll[i]
        }
        return diceValues
    }
    
    static func returnRollSymbols(fill: Bool = true) -> [String] {
        var rollSymbols: [String] = [String]()
        generatedRoll.forEach { i in
            rollSymbols.append("die.face." + String(i) + (fill ? ".fill" : ""))
        }
        return rollSymbols
    }
    static func returnFirstRollSymbol(fill: Bool = true) -> String {
        return "die.face." + String(generatedRoll[0]) + (fill ? ".fill" : "")
    }
    
    static func animateSingleDieRoll(fill: Bool = true) -> [UIImage] {
        var dieRollAnimation = [UIImage]()
        for _ in 1...12 {
            dieRollAnimation.append(UIImage(systemName: "die.face." + String(Int.random(in: 1...noOfSides)) + (fill ? ".fill" : ""))!)
        }
        dieRollAnimation.append(UIImage(systemName: returnFirstRollSymbol())!)
        return dieRollAnimation
    }
}

