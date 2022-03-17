//
//  SnakeAndLadder.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 17/03/22.
//

import Foundation

struct SnakeAndLadder {
    var snakeStart: Int //need to add observable here
    var ladderStart: Int //need to add observable here
    var size: lengthSnakeAndLadder
    var length: Int {
        switch size {
        case .small:
            return Limits.lengthSmall
        case .medium:
            return Limits.lengthMedium
        case .large:
            return Limits.lengthLarge
        case .extraLarge:
            return Limits.lengthExtraLarge
        }
    }
}
