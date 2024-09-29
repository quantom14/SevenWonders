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
                .padding()
            Text(" Tap the '+' button to add a new game.")
        }
        .foregroundColor(.gray)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyGameView()
}
