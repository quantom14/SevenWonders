//
//  ProfileView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 27/09/2024.
//

import PhotosUI
import SwiftData
import SwiftUI

struct ProfileHostView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Profile.name) private var profiles: [Profile]

    @State private var isPresentingNewProfile = false

    var body: some View {
        NavigationView {
            VStack {
                if let profile = profiles.first {
                    ProfileView(profile: profile)
                } else {
                    EmptyProfileView()
                }
            }
            .navigationTitle("Profile")
            .frame(minWidth: 300)
            .toolbar {
                ToolbarItem {
                    if profiles.isEmpty {
                        AddProfileButton(isPresentingNewProfile: $isPresentingNewProfile)
                    }
                }
            }
            .onAppear {
                if profiles.isEmpty {
                    isPresentingNewProfile = true
                }
            }
            .sheet(isPresented: $isPresentingNewProfile) {
                NewProfileView(isPresented: $isPresentingNewProfile)
            }
        }
    }

    private struct AddProfileButton: View {
        @Binding var isPresentingNewProfile: Bool

        var body: some View {
            Button(action: {
                isPresentingNewProfile = true
            }) {
                Image(systemName: "plus")
            }
        }
    }
}

#Preview {
    ProfileHostView()
        .environment(\.modelContext, PreviewMock.createModelContextMock())
}
