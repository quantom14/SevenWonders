//
//  SevenWondersApp.swift
//  SevenWonders
//
//  Created by Tom Bintener on 15/09/2024.
//

import SwiftData
import SwiftUI

@main
struct SevenWondersApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Game.self,
            Profile.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
