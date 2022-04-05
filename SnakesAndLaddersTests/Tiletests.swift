//
//  Tiletests.swift
//  SnakesAndLaddersTests
//
//  Created by Kartik Narayanan on 01/04/22.
//

import XCTest
@testable import SnakesAndLadders

class Tiletests: XCTestCase {
    var tile1 = Tile(tId: 1, tIndex: 0)
    var tiles = [Tile(tId: 2, tIndex: 1), Tile(tId: 3, tIndex: 2)]
    
    func testTileHasBeenCreatedWithId() {
        XCTAssertEqual(tile1.tId, 1)
    }
    
    func testTilesHaveBeenCreatedWithIndex() {
        XCTAssertEqual(tile1.tIndex, 0)
    }

    func testTilesHaveAlternatingBackgroundColors() {
        XCTAssertNotEqual(tiles[0].tColor, tiles[1].tColor)
        XCTAssertEqual(tile1.tColor, tiles[1].tColor)
    }

    func testTilesHaveAlternatingTextColors() {
        XCTAssertNotEqual(tiles[0].tTextColor, tiles[1].tTextColor)
        XCTAssertEqual(tile1.tTextColor, tiles[1].tTextColor)
    }

}
