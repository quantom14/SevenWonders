//
//  ContentView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 15/09/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    let dateFormat: Date.FormatStyle = .init(date: .numeric, time: .shortened)

    @State private var selection: Tab = .games

    enum Tab {
        case games
        case stats
    }

    var body: some View {
        TabView(selection: $selection) {
            GameNavigationView()
                .tabItem {
                    Label("Games", systemImage: "die.face.4.fill")
                }
                .tag(Tab.games)
            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }
                .tag(Tab.stats)
        }
    }
}

#Preview {
    ContentView()
        .environment(\.modelContext, PreviewMock.createModelContextMock())
}
