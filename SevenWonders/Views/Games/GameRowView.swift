//
//  ContentView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 15/09/2024.
//

import SwiftData
import SwiftUI

struct GameRowView: View {
    var game: Game

    let dateFormat: Date.FormatStyle = .init(date: .numeric, time: .shortened)

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(game.displayPlayers())
                    .bold()
                Text(game.date, format: dateFormat)
            }
            Spacer()
            HStack {
                Text(game.determineWinner().name)
                Image(systemName: "crown.fill")
                    .foregroundColor(.yellow)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    GameRowView(game: PreviewMock.generateRandomGame())
}
