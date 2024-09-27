//
//  ContentView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 15/09/2024.
//

import SwiftData
import SwiftUI

struct GameNavigationView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var games: [Game]

    @State private var isPresentingNewGame: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                if !games.isEmpty {
                    GameListView()
                } else {
                    EmptyGameView()
                }
            }
            .navigationTitle("Games")
            .frame(minWidth: 300)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    AddButton(isPresentingNewGame: $isPresentingNewGame)
                }
            }
            .sheet(isPresented: $isPresentingNewGame) {
                NewGameView()
            }
        }
    }
}

private struct AddButton: View {
    @Binding var isPresentingNewGame: Bool

    var body: some View {
        Button(action: {
            isPresentingNewGame = true
        }) {
            Image(systemName: "plus")
        }
    }
}

#Preview {
    GameNavigationView()
        .environment(\.modelContext, PreviewMock.createModelContextMock())
}
