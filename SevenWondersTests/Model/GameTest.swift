//
//  PlayerTest.swift
//  SevenWondersTests
//
//  Created by Tom Bintener on 15/09/2024.
//

import Testing

@Test func test_create_valid_game() {
    #expect(throws: Never.self) {
        try randomPlayer().build()
    }
}

@Test func test_create_game_simultaneous_player_victories() {
    #expect(throws: GameValidationError.multipleVictoryCondition) {
        try Game.Builder()
            .player1(randomPlayer().militaryVictory(true).scientificVictory(false).build())
            .player2(randomPlayer().militaryVictory(true).scientificVictory(false).build())
            .build()
    }
}

@Test func test_create_game_missing_player1() {
    #expect(throws: GameValidationError.emptyPlayer) {
        try Game.Builder()
            .player2(randomPlayer().build())
            .build()
    }
}

@Test func test_create_game_missing_player2() {
    #expect(throws: GameValidationError.emptyPlayer) {
        try Game.Builder()
            .player1(randomPlayer().build())
            .build()
    }
}

func randomGame() throws -> Game.Builder {
    let player1: Player = try randomPlayer().build()
    let player2: Player = try randomPlayer().build()

    return Game.Builder()
        .player1(player1)
        .player2(player2)
}
