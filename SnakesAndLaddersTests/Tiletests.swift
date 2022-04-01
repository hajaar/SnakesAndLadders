//
//  Tiletests.swift
//  SnakesAndLaddersTests
//
//  Created by Kartik Narayanan on 01/04/22.
//

import XCTest
@testable import SnakesAndLadders

class Tiletests: XCTestCase {
    var tile1 = Tile(tId: 1)
    var tiles = [Tile(tId: 2), Tile(tId: 3)]
    
    func testTileHasBeenCreatedWithId() {
        XCTAssertEqual(tile1.tId, 1)
    }
    
    func testTilesHaveBeenCreatedWithSequentialIds() {
        let currentIndex = tile1.tIndex
        XCTAssertEqual(tiles[0].tIndex, currentIndex + 1)
        XCTAssertEqual(tiles[1].tIndex, currentIndex + 2)
    }

}
