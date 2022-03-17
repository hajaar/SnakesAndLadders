//
//  Player.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 17/03/22.
//

import Foundation

struct Player {
    let name: String
    let token: String
    var balance: Int = 0
    var createdSnakesAndLadders: [SnakeAndLadder] = []
    var wins: Int = 0
    var remainingSnakesAndLaddersOptions: [lengthSnakeAndLadder] = [.small, .medium, .large, .extraLarge]
}


