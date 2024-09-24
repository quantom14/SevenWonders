//
//  ContentView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 15/09/2024.
//

import SwiftData
import SwiftUI

struct EmptyGameView: View {
    var body: some View {
        VStack {
            Text("Time to start playing!")
            Text("")
            Text(" Tap the '+' button to add a new game.")
            // Spacer() // Push the message to the top
        }
        .foregroundColor(.gray)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill the space
    }
}

#Preview {
    EmptyGameView()
}
