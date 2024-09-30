//
//  ProfileImagePickerView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 01/10/2024.
//

import PhotosUI
import SwiftUI

struct ProfileImagePickerView: View {
    @State private var selectedImage: PhotosPickerItem? = nil
    @Binding var profileImage: Data?
    // TODO: implement a crop to square possibility to avoid warped picture
    var body: some View {
        PhotosPicker(selection: $selectedImage, matching: .images) {
            ProfileImageView(imageData: profileImage)
        }
        .onChange(of: selectedImage) {
            Task {
                await loadSelectedImage()
            }
        }
    }

    func loadSelectedImage() async {
        if let selectedImage {
            if let data = try? await selectedImage.loadTransferable(type: Data.self) {
                profileImage = data
            }
        }
    }
}

#Preview {
    @Previewable @State var imageData = UIImage(named: "Salem")!.pngData()
    ProfileImagePickerView(profileImage: $imageData)
}
