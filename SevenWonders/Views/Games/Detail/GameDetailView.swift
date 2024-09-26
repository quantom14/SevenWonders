//
//  ContentView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 15/09/2024.
//

import SwiftData
import SwiftUI

struct GameDetailView: View {
    var game: Game

    let dateFormat: Date.FormatStyle = .init(date: .numeric, time: .shortened)

    var body: some View {
        Text("Game at \(game.date, format: dateFormat)")
    }
}

#Preview {
    GameDetailView(game: PreviewMock.generateRandomGame())
}
