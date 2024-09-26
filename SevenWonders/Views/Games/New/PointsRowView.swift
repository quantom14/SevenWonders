//
//  PointsRowView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 26/09/2024.
//

import SwiftUI

struct PointsRowView: View {
    @Binding var points: [Int?]

    var systemImage: String
    var color: Color

    var body: some View {
        HStack {
            Label("", systemImage: systemImage)
                .foregroundColor(color)
            PlayerPoints(player: "Player 1", playerPoints: $points[0])
            PlayerPoints(player: "Player 2", playerPoints: $points[1])
        }
    }
}

struct PlayerPoints: View {
    var player: String
    @Binding var playerPoints: Int?

    var body: some View {
        TextField(player, value: $playerPoints, formatter: NumberFormatter())
            .keyboardType(.numberPad)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}
