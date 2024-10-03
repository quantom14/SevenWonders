//
//  NewProfileView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 27/09/2024.
//

import SwiftData
import SwiftUI

struct ProfileView: View {
    @Query private var games: [Game]
    var profile: Profile

    @State private var isPresented: Bool = false
    @State private var isPressing: Bool = false

    var body: some View {
        Form {
            Section(header: Text("Player")) {
                HStack {
                    Text(profile.name)
                        .font(.largeTitle)
                        .padding()
                    Spacer()
                    ProfileImageView(imageData: profile.profileImageData)
                        .onLongPressGesture(minimumDuration: 0.3, pressing: { pressing in
                            isPressing = pressing
                            if pressing {
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                generator.impactOccurred()
                            }
                        }) {
                            isPresented = true
                        }
                        .shadow(color: isPressing ? Color.gray.opacity(0.6) : Color.clear, radius: 10, x: 0, y: 0)
                        .scaleEffect(isPressing ? 1.1 : 1.0) // Scale the circle when pressing
                        .animation(.easeInOut(duration: 0.3), value: isPressing) // Smooth animation
                }
            }

            Section(header: Text("Player Information")) {
                HStack {
                    Text("Games Played")
                    Spacer()
                    Text("\(getPlayedGames(profile: profile).count)")
                }.padding()
                HStack {
                    Text("Games Won")
                    Spacer()
                    Text("\(getWonGames(profile: profile).count)")
                }.padding()
                HStack {
                    Text("Highest Score")
                    Spacer()
                    Text("\(getHighscore(profile: profile))")
                }.padding()
            }
        }
        .sheet(isPresented: $isPresented) {
            EditProfileView(isPresented: $isPresented)
        }
    }

    private func getHighscore(profile: Profile) -> Int {
        let filteredGames = getPlayedGames(profile: profile)

        let scores = filteredGames.map { game in
            // Check if the profile name matches player1 or player2 and return their score
            if game.player1.name == profile.name {
                return game.player1.totalPoints
            } else if game.player2.name == profile.name {
                return game.player2.totalPoints
            } else {
                return 0 // Default case, though it should not occur due to the filter
            }
        }
        return scores.max() ?? 0 // Return the highest score, defaulting to 0 if empty
    }

    private func getWonGames(profile: Profile) -> [Game] {
        return games.filter { game in
            game.determineWinner().name == profile.name
        }
    }

    private func getPlayedGames(profile: Profile) -> [Game] {
        return games.filter { game in
            game.player1.name == profile.name || game.player2.name == profile.name
        }
    }
}

#Preview {
    ProfileView(profile: Profile(name: "Tom"))
        .environment(\.modelContext, PreviewMock.createModelContextMock())
}
