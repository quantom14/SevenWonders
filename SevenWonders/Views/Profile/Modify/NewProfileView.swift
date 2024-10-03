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

    @State var isImagePickerPresented: Bool = false
    @State private var selectedImgage: UIImage?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Player")) {
                    HStack {
                        TextField("Name", text: $name)
                            .font(.largeTitle)
                            .padding()
                        Spacer()
                        Button(action: {
                            isImagePickerPresented = true
                        }) {
                            ProfileImageView(uiImage: selectedImgage)
                        }
                        .sheet(isPresented: $isImagePickerPresented) {
                            // Present the ImagePickerView
                            ProfileImagePickerView(selectedImage: $selectedImgage, isPresented: $isImagePickerPresented)
                        }
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
        let newProfile = Profile(name: name, profileImage: selectedImgage?.pngData())
        modelContext.insert(newProfile)
        try? modelContext.save()
        // Dismiss the sheet after saving
        isPresented = false
    }
}

#Preview {
    @Previewable @State var isPresentedMock = true

    NewProfileView(isPresented: $isPresentedMock, isImagePickerPresented: false)
        .environment(\.modelContext, PreviewMock.createModelContextMock())
}
