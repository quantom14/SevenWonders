//
//  ContentView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 15/09/2024.
//

import SwiftData
import SwiftUI

struct EmptyProfileView: View {
    @State private var isPresentingNewProfile = false

    var body: some View {
        NavigationView {
            VStack {
                Text("No profile created yet.")
                    .padding()
                Text(" Tap the '+' button to create a profile.")
            }
        }
        .foregroundColor(.gray)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyProfileView()
}
