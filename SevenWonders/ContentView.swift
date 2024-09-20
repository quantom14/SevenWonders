//
//  ContentView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 15/09/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var games: [Game]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(games) { game in
                    NavigationLink {
                        Text("Game at \(game.date, format: Date.FormatStyle(date: .numeric, time: .shortened))")
                    } label: {
                        Text(game.date, format: Date.FormatStyle(date: .numeric, time: .shortened))
                        Text(game.displayPlayers())
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addGame) {
                        Label("Add Game", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a game")
        }
    }

    private func addGame() {
        withAnimation {
            let player1: Player = try! Player.Builder().name("Player1").build()
            let player2: Player = try! Player.Builder().name("Player2").build()

            let newGame = try! Game.Builder()
                .player1(player1)
                .player2(player2)
                .build()

            modelContext.insert(newGame)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(games[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Game.self, inMemory: true)
}
