//
//  NewProfileView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 27/09/2024.
//

import PhotosUI
import SwiftData
import SwiftUI

struct EditProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var profiles: [Profile]

    @Binding var isPresented: Bool

    @State private var showAlert: Bool = false // State variable to show the alert
    @State var name: String = ""
    @State var isImagePickerPresented: Bool = false
    @State private var selectedImage: UIImage?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Player")) {
                    HStack {
                        TextField("Name", text: $name)
                            .font(.largeTitle)
                            .padding()
                        Spacer()

                        // Button to show image picker
                        Button(action: {
                            isImagePickerPresented = true
                        }) {
                            ProfileImageView(uiImage: selectedImage)
                        }
                        .sheet(isPresented: $isImagePickerPresented) {
                            // Present the ImagePickerView
                            ProfileImagePickerView(selectedImage: $selectedImage, isPresented: $isImagePickerPresented)
                        }
                    }
                }

                Section {
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
                    if let profileImage = profile.profileImageData {
                        selectedImage = UIImage(data: profileImage)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        isPresented = false // Dismiss the sheet without saving
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveProfile()
                    }
                    .disabled(name.isEmpty)
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
        profile.profileImageData = selectedImage?.pngData() // Update the profile image
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
    @Previewable @State var isPresentedMock = false

    EditProfileView(isPresented: $isPresentedMock)
        .environment(\.modelContext, PreviewMock.createModelContextMock())
}
