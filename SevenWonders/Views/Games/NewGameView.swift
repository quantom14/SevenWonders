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
    @State private var points: [[Int?]] = Array(repeating: [nil, nil], count: 8)
    @State private var victories: [[Bool]] = Array(repeating: [false, false], count: 2)
    @State private var gameDate: Date = .init()

    let categories = [
        (color: Color.blue, systemImage: "square.fill"),
        (color: Color.green, systemImage: "square.fill"),
        (color: Color.yellow, systemImage: "square.fill"),
        (color: Color.purple, systemImage: "square.fill"),
        (color: Color.brown, systemImage: "pyramid.fill"),
        (color: Color.green, systemImage: "circle.fill"),
        (color: Color.brown, systemImage: "circle.fill"),
        (color: Color.red, systemImage: "square.fill")
    ]

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
                    ForEach(points.indices, id: \.self) { index in
                        PointsRowView(
                            points: $points[index],
                            systemImage: categories[index].systemImage,
                            color: categories[index].color
                        )
                    }
                }

                Section(header: Text("Victory Conditions")) {
                    VictoryRowView(victories: $victories[0], systemImage: "circle", color: .red)
                    VictoryRowView(victories: $victories[1], systemImage: "circle", color: .green)
                }

                Section(header: Text("Game Date")) {
                    DatePicker("Date", selection: $gameDate, displayedComponents: .date)
                }

                Section {
                    Button("Save Game") {
                        let newGame: Game = PreviewMock.generateRandomGame()
                        modelContext.insert(newGame)
                        dismiss()
                    }
                }
            }
        }
        .navigationTitle("New Game")
        .navigationBarItems(leading: Button("Cancel") {
            dismiss()
        })
    }
}

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

    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.zeroSymbol = ""
        return formatter
    }()

    var body: some View {
        TextField(player, value: $playerPoints, formatter: formatter)
            .keyboardType(.numberPad)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct VictoryRowView: View {
    @Binding var victories: [Bool]

    var systemImage: String
    var color: Color

    var body: some View {
        HStack {
            Label("", systemImage: systemImage)
                .foregroundColor(color)
            Toggle("", isOn: $victories[0])
            Toggle("", isOn: $victories[1])
        }
    }
}

#Preview {
    NewGameView()
}
