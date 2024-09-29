//
//  PreviewData.swift
//  SevenWonders
//
//  Created by Tom Bintener on 21/09/2024.
//

import Foundation
import SwiftData
import SwiftUI

public class PreviewMock {
    static func createEmptyModelContextMock() -> ModelContext {
        // Initialize an in-memory model context
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Game.self, Player.self, Profile.self, configurations: configuration)
        let modelContext = ModelContext(container)

        // Return the populated model context
        return modelContext
    }

    static func createModelContextMock() -> ModelContext {
        // Initialize an in-memory model context
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Game.self, Player.self, Profile.self, configurations: configuration)
        let modelContext = ModelContext(container)

        // Create some mock data
        var games = generateRandomGames(count: 12)

        let player1: Player = try! randomPlayer().name("Tom").build()
        let player2: Player = try! randomPlayer().name("Maria").build()
        games.append(generateRandomGameWithPlayers(player1: player1, player2: player2)) // Tom played 1 game as player 1
        games.append(generateRandomGameWithPlayers(player1: player2, player2: player1)) // Tom played 1 game as player 2

        // Add mock data to the model context
        for game in games {
            modelContext.insert(game)
        }

        modelContext.insert(Profile(name: "Tom"))

        // Return the populated model context
        return modelContext
    }

    static func generateRandomGames(count: Int) -> [Game] {
        return (1 ... count).map { _ in generateRandomGame() }
    }

    static func generateRandomGame() -> Game {
        let player1: Player = try! randomPlayer().build()
        let player2: Player = try! randomPlayer().build()
        return generateRandomGameWithPlayers(player1: player1, player2: player2)
    }

    static func generateRandomGameWithPlayers(player1: Player, player2: Player) -> Game {
        return try! Game.Builder()
            .date(randomDate(startingFrom: 2020, upTo: 2024))
            .player1(player1)
            .player2(player2)
            .build()
    }

    static func randomPlayer() -> Player.Builder {
        return Player.Builder()
            .name(randomName())
            .bluePoints(randomInt(min: 0, max: 10))
            .greenPoints(randomInt(min: 0, max: 10))
            .yellowPoints(randomInt(min: 0, max: 10))
            .purplePoints(randomInt(min: 0, max: 10))
            .pyramidPoints(randomInt(min: 0, max: 10))
            .tokenPoints(randomInt(min: 0, max: 10))
            .coinPoints(randomInt(min: 0, max: 10))
            .militaryPoints(randomInt(min: 0, max: 10))
    }

    static func randomName() -> String {
        // List of 20 sample names
        let names = [
            "Alice", "Bob", "Charlie", "Daisy", "Edward",
            "Fiona", "George", "Hannah", "Ian", "Jessica",
            "Kevin", "Laura", "Michael", "Nina", "Oscar",
            "Paula", "Quincy", "Rachel", "Steve", "Teresa"
        ]
        // Return a random name from the list
        return names.randomElement() ?? "Unknown"
    }

    static func randomInt(min: Int, max: Int) -> Int {
        return Int.random(in: min ..< max)
    }

    static func randomDate(startingFrom startYear: Int, upTo endYear: Int) -> Date {
        // Create a date formatter to help with the generation of dates
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"

        // Create the start and end dates from the given years
        guard let startDate = dateFormatter.date(from: "\(startYear)/01/01"),
              let endDate = dateFormatter.date(from: "\(endYear)/12/31")
        else {
            fatalError("Invalid date range provided.")
        }

        // Get the time intervals for the start and end dates
        let startInterval = startDate.timeIntervalSince1970
        let endInterval = endDate.timeIntervalSince1970

        // Generate a random time interval between the start and end intervals
        let randomInterval = TimeInterval.random(in: startInterval ... endInterval)

        // Create and return the random date
        return Date(timeIntervalSince1970: randomInterval)
    }
}
