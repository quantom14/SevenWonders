//
//  NewProfileView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 27/09/2024.
//

import SwiftData
import SwiftUI

struct NewProfileView: View {
    @Binding var isPresented: Bool
    @Environment(\.modelContext) private var modelContext

    @State private var name: String = ""
    @State private var profileImage: Data?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Player")) {
                    HStack {
                        TextField("Name", text: $name)
                            .font(.largeTitle)
                            .padding()
                        Spacer()
                        ProfileImagePickerView(profileImage: $profileImage)
                    }
                }

                Section {
                    Button("Save") {
                        saveProfile()
                    }
                    .disabled(name.isEmpty)
                }
            }
            .navigationTitle("New Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        isPresented = false // Dismiss the sheet without saving
                    }
                }
            }
        }
    }

    private func saveProfile() {
        // Create and save the profile
        let newProfile = Profile(name: name, profileImage: profileImage)
        modelContext.insert(newProfile)
        try? modelContext.save()
        // Dismiss the sheet after saving
        isPresented = false
    }
}

#Preview {
    @Previewable @State var isPresentedMock = true

    NewProfileView(isPresented: $isPresentedMock)
        .environment(\.modelContext, PreviewMock.createModelContextMock())
}
