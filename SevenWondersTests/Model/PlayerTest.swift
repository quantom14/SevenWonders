//
//  PlayerTest.swift
//  SevenWondersTests
//
//  Created by Tom Bintener on 15/09/2024.
//

import Testing

@Test func test_create_valid_player() {
    #expect(throws: Never.self) {
        try randomPlayer().build()
    }
}

@Test func test_create_player_wihtout_name() {
    #expect(throws: PlayerValidationError.emptyName) {
        try Player.Builder().name("").build()
    }
}

@Test func test_create_invalid_player() {
    #expect(throws: PlayerValidationError.multipleVictoryCondition) {
        try randomPlayer()
            .militaryVictory(true)
            .scientificVictory(true)
            .build()
    }
}

func randomPlayer() -> Player.Builder {
    return Player.Builder()
        .name("Tom")
        .bluePoints(Int.random(in: 0 ..< 10))
        .greenPoints(Int.random(in: 0 ..< 10))
        .yellowPoints(Int.random(in: 0 ..< 10))
        .purplePoints(Int.random(in: 0 ..< 10))
        .pyramidPoints(Int.random(in: 0 ..< 10))
        .tokenPoints(Int.random(in: 0 ..< 10))
        .coinPoints(Int.random(in: 0 ..< 10))
        .militaryPoints(Int.random(in: 0 ..< 10))
}
