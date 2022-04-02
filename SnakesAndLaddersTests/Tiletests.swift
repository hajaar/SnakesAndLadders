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
    
    func testTilesHaveBeenCreatedWithSequentialIds() {
        XCTAssertEqual(tile1.tIndex, 0)
        XCTAssertEqual(tiles[0].tIndex, 1)
        XCTAssertEqual(tiles[1].tIndex, 2)
    }
}
