//
//  NewGame.swift
//  SevenWonders
//
//  Created by Tom Bintener on 22/09/2024.
//

import SwiftUI

struct NewGameView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var names: [String] = Array(repeating: "", count: 2)

    @State private var bluePoints: [Int?] = Array(repeating: nil, count: 2)
    @State private var greenPoints: [Int?] = Array(repeating: nil, count: 2)
    @State private var yellowPoints: [Int?] = Array(repeating: nil, count: 2)
    @State private var purplePoints: [Int?] = Array(repeating: nil, count: 2)
    @State private var pyramidPoints: [Int?] = Array(repeating: nil, count: 2)
    @State private var tokenPoints: [Int?] = Array(repeating: nil, count: 2)
    @State private var coinPoints: [Int?] = Array(repeating: nil, count: 2)
    @State private var militaryPoints: [Int?] = Array(repeating: nil, count: 2)

    @State private var militaryVictory: [Bool] = Array(repeating: false, count: 2)
    @State private var scientificVictory: [Bool] = Array(repeating: false, count: 2)

    @State private var gameDate: Date = .init()

    @State private var isPresentingError: Bool = false
    @State private var errorMessage: String = ""

    @Binding var isPresentingNewGame: Bool

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Players")) {
                    HStack {
                        TextField("Player 1 Name", text: $names[0])
                        Spacer()
                        TextField("Player 2 Name", text: $names[1])
                    }
                }

                Section(header: Text("Points")) {
                    PointsRowView(points: $bluePoints, systemImage: "square.fill", color: Color.blue)
                    PointsRowView(points: $greenPoints, systemImage: "square.fill", color: Color.green)
                    PointsRowView(points: $yellowPoints, systemImage: "square.fill", color: Color.yellow)
                    PointsRowView(points: $purplePoints, systemImage: "square.fill", color: Color.purple)
                    PointsRowView(points: $pyramidPoints, systemImage: "pyramid.fill", color: Color.brown)
                    PointsRowView(points: $tokenPoints, systemImage: "circle.fill", color: Color.green)
                    PointsRowView(points: $coinPoints, systemImage: "circle.fill", color: Color.brown)
                    PointsRowView(points: $militaryPoints, systemImage: "square.fill", color: Color.red)
                }

                Section(header: Text("Victory Conditions")) {
                    VictoryRowView(victory: $militaryVictory, systemImage: "circle", color: .red)
                    VictoryRowView(victory: $scientificVictory, systemImage: "circle", color: .green)
                }

                Section(header: Text("Game Date")) {
                    DatePicker("Date", selection: $gameDate, displayedComponents: .date)
                }

                Section {
                    Button("Save Game") {
                        saveNewGame()
                    }.alert(isPresented: $isPresentingError) {
                        Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                    }
                }

                Section {
                    Button("Random Game") {
                        let newGame: Game = PreviewMock.generateRandomGame()
                        modelContext.insert(newGame)
                    }
                }
            }
            .navigationTitle("New Game")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        isPresentingNewGame = false // Dismiss the sheet without saving
                    }
                }
            }
        }
    }

    fileprivate func saveNewGame() {
        let players: [Player] = getPlayers()

        do {
            if players.count == 2 {
                let game: Game = try Game.Builder()
                    .date(gameDate)
                    .player1(players[0])
                    .player2(players[1])
                    .build()
                modelContext.insert(game)
                dismiss()
            }
        } catch {
            onError(error: error)
        }
    }

    fileprivate func getPlayers() -> [Player] {
        var players: [Player] = []
        do {
            for i in 0 ..< 2 {
                let player = try Player.Builder()
                    .name(names[i])
                    .bluePoints(bluePoints[i] ?? 0)
                    .greenPoints(greenPoints[i] ?? 0)
                    .yellowPoints(yellowPoints[i] ?? 0)
                    .purplePoints(purplePoints[i] ?? 0)
                    .pyramidPoints(pyramidPoints[i] ?? 0)
                    .tokenPoints(tokenPoints[i] ?? 0)
                    .coinPoints(coinPoints[i] ?? 0)
                    .militaryPoints(militaryPoints[i] ?? 0)
                    .militaryVictory(militaryVictory[i])
                    .scientificVictory(scientificVictory[i])
                    .build()
                players.append(player)
            }
        } catch {
            onError(error: error)
        }
        return players
    }

    fileprivate func onError(error: Error) {
        switch error {
        case let error as PlayerValidationError:
            errorMessage = error.errorMessage
        case let error as GameValidationError:
            errorMessage = error.errorMessage
        default:
            errorMessage = error.localizedDescription
        }
        isPresentingError = true
        print(error)
    }
}

#Preview {
    @Previewable @State var isPresentingNewGame = true
    NewGameView(isPresentingNewGame: $isPresentingNewGame)
}
