//
//  ContentView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 15/09/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .games

    enum Tab {
        case games
        case stats
        case profile
    }

    let statsViewImplemented = false // TODO: implement a Stats View

    var body: some View {
        TabView(selection: $selection) {
            GameNavigationView()
                .tabItem {
                    Label("Games", systemImage: "die.face.4.fill")
                }
                .tag(Tab.games)
            if statsViewImplemented {
                StatsView()
                    .tabItem {
                        Label("Stats", systemImage: "chart.bar.fill")
                    }
                    .tag(Tab.stats)
            }
            ProfileHostView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .tag(Tab.profile)
        }
    }
}

#Preview {
    ContentView()
        .environment(\.modelContext, PreviewMock.createModelContextMock())
}
