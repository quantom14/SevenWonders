//
//  GameListView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 22/09/2024.
//

import SwiftData
import SwiftUI

struct GameListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var games: [Game]

    var body: some View {
        List {
            ForEach(getGamesSortedByDate()) { game in
                NavigationLink {
                    GameDetailView(game: game)
                } label: {
                    GameRowView(game: game)
                }
            }
            .onDelete(perform: deleteItems)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(getGamesSortedByDate()[index])
            }
        }
    }

    private func getGamesSortedByDate() -> [Game] {
        games.sorted(by: { $0.date > $1.date })
    }
}

#Preview {
    GameListView()
        .environment(\.modelContext, PreviewMock.createModelContextMock())
}
