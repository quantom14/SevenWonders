//
//  VictoryRowView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 26/09/2024.
//

import SwiftUI

struct VictoryRowView: View {
    @Binding var victory: [Bool]

    var systemImage: String
    var color: Color

    var body: some View {
        HStack {
            Label("", systemImage: systemImage)
                .foregroundColor(color)
            Toggle("", isOn: $victory[0])
            Toggle("", isOn: $victory[1])
        }
    }
}
