//
//  NewProfileView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 27/09/2024.
//

import SwiftData
import SwiftUI

struct EditProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var profiles: [Profile]

    @Binding var isPresented: Bool

    @State private var showAlert: Bool = false // State variable to show the alert
    @State var name: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Player")) {
                    HStack {
                        TextField("Name", text: $name)
                            .font(.largeTitle)
                            .padding()
                        Spacer()
                        Image(systemName: "person.circle")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 80, height: 80)
                    }
                }
                Section {
                    Button("Save") {
                        saveProfile()
                    }
                    .disabled(name.isEmpty)
                    Button("Delete") {
                        showAlert = true
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Edit Profile")
            .onAppear {
                if let profile = profiles.first {
                    name = profile.name
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        isPresented = false // Dismiss the sheet without saving
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Delete Profile"),
                    message: Text("Are you sure you want to delete this profile?"),
                    primaryButton: .destructive(Text("Delete")) {
                        deleteProfile() // Call delete function if confirmed
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }

    private func saveProfile() {
        guard let profile = profiles.first else { return } // Get the first profile to update
        profile.name = name // Update the name
        try? modelContext.save() // Save the changes
        isPresented = false
    }

    private func deleteProfile() {
        guard let profile = profiles.first else { return } // Get the first profile to delete
        modelContext.delete(profile) // Delete the profile
        isPresented = false
    }
}

#Preview {
    @Previewable @State var isPresentedMock = true

    EditProfileView(isPresented: $isPresentedMock)
        .environment(\.modelContext, PreviewMock.createModelContextMock())
}
