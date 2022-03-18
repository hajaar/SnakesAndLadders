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
    static private var generatedRoll: [Int] = [Int]()
    
    static func create(numberOfDice: Int = 1, numberOfSides: Int = 6) {
        self.noOfDice = numberOfDice
        self.noOfSides = numberOfSides
        roll()
    }
    
    static private func roll() {
        generatedRoll = [Int]()
        for _ in 0...noOfDice - 1 {
            generatedRoll.append(Int.random(in: 1...noOfSides))
        }
    }
    
    
    static func rollArray() -> [Int] {
        roll()
        return generatedRoll
    }
    
    static func rollSum() -> Int {
        var diceValues = 0
        for i in 0...noOfDice - 1{
            diceValues += generatedRoll[i]
        }
        return diceValues
    }
}
