//
//  PlayerTests.swift
//  SnakesAndLaddersTests
//
//  Created by Kartik Narayanan on 01/04/22.
//

import XCTest
@testable import SnakesAndLadders

class PlayerTests: XCTestCase {

    var player = Player(playerID: 1, name: "Gummeemama", token: "capsule.fill")
    
    func testPlayerIsCreatedWithId() {
        XCTAssertEqual(player.getId(), 1)
    }

    func testPlayerIsCreatedWithName() {
        XCTAssertEqual(player.getName(), "Gummeemama")
    }
    
    func testPlayerIsCreatedWithToken() {
        XCTAssertEqual(player.getToken(), "capsule.fill")
    }
    
    func testPlayerIsCreatedWithNormalNextTurnType() {
        XCTAssertEqual(player.getNextTurnType(), TurnType.normal)
    }
    
    func testPlayerHasBeenCreatedAtPositionOne() {
        XCTAssertEqual(player.getPosition(), 1)
    }
    
    func testPlayerHasAnImageOnCreation() {
        let tmpImage = UIImage(systemName: "\(1)\(symbolNames.playerName)")
        XCTAssertEqual(player.getPlayerImage(), tmpImage)
    }
    
    func testPlayerReturnsUnmodifiedRollValueWhenTurnTypeIsNormal() {
        let roll = 4
        let modifiedRoll = player.nextTurnValue(roll: 4)
        XCTAssertEqual(modifiedRoll, roll)
    }
    
    func testPlayerIsSetWithFastNextTurnType() {
        player.setNextTurnType(turnType: .fast)
        XCTAssertEqual(player.getNextTurnType(), TurnType.fast)
    }
    
    func testPlayerReturnsDoubledModifiedRollValueWhenTurnTypeIsFast() {
        player.setNextTurnType(turnType: .fast)
        let modifiedRoll = player.nextTurnValue(roll: 5)
        XCTAssertEqual(modifiedRoll, 10)
        XCTAssertEqual(player.getNextTurnType(), .normal)
    }
    
    func testPlayerReturnsRoundedDownModifiedRollValueWhenTurnTypeIsSlow() {
        player.setNextTurnType(turnType: .slow)
        let modifiedRoll = player.nextTurnValue(roll: 5)
        XCTAssertEqual(modifiedRoll, 2)
        XCTAssertEqual(player.getNextTurnType(), .normal)
    }

    func testPlayerHasANewPosition() {
        player.setPosition(2)
        XCTAssertEqual(player.getPosition(), 2)
    }
    
    func testPlayerShouldNotMoveBeyondMaximumSizeOfBoardnDiceRoll() {
        player.setPosition(99)
        XCTAssertEqual(player.playerRollsDice(), 99)
    }

}
