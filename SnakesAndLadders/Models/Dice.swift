//
//  Dice.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 18/03/22.
//

import Foundation
struct Dice {
    static private var noOfDice: Int = 1
    static private var noOfSides: Int = 6
    
    static func createDice(numberOfDice: Int = 1, numberOfSides: Int = 6) {
        self.noOfDice = numberOfDice
        self.noOfSides = numberOfSides
    }
    
    static func rollDiceIndividual() -> [Int] {
        var diceValues = [Int]()
        for _ in 0...noOfDice - 1{
            diceValues.append(Int.random(in: 1...noOfSides))
        }
        return diceValues
    }
    
    static func rollDiceTotal() -> Int {
        var diceValues = 0
        for _ in 0...noOfDice - 1{
            diceValues += Int.random(in: 1...noOfSides)
        }
        return diceValues
    }
}
