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

    var body: some View {
        ZStack {
            // Outer Rectangle - Full Screen
            Rectangle()
                .fill(Color.brown.opacity(0.6)) // Outer rectangle background color
                .ignoresSafeArea() // Extend beyond safe area
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Inner Rectangle with Padding
            VStack {
                Text(game.formattedDate()).padding(.bottom, 5)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white) // Inner rectangle background color
                    .shadow(radius: 10, x: 5, y: 5) // Optional shadow for the inner rectangle
                    .overlay(
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                            VStack {
                                // TODO: display selected game
                                Text("Game Detail View")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                        }
                    )
                    .padding([.horizontal, .bottom], 20)
            }
        }
    }
}

#Preview {
    GameDetailView(game: PreviewMock.generateRandomGame())
}
