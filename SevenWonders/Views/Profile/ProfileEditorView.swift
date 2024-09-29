//
//  ProfileView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 27/09/2024.
//

import PhotosUI
import SwiftData
import SwiftUI

struct ProfileEditorView: View {
    @State private var name: String = "Player Name"
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var profileImage: Image? = nil

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Players")) {
                    // PhotosPicker to allow user to select a profile picture
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Text("Select Profile Picture")
                            .foregroundColor(.blue)
                            .padding()
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            // Load the image from the selected photo
                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data)
                            {
                                profileImage = Image(uiImage: uiImage)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileEditorView()
}
