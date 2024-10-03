//
//  ProfileImageView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 30/09/2024.
//

import SwiftUI

struct ProfileImageView: View {
    var imageData: Data? = nil
    var uiImage: UIImage? = nil

    // Initializer for Data input
    init(imageData: Data?) {
        self.imageData = imageData
    }

    // Initializer for UIImage input
    init(uiImage: UIImage?) {
        self.uiImage = uiImage
    }

    var body: some View {
        if let uiImage = uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
        } else if let data = imageData, let image = UIImage(data: data) {
            Image(uiImage: image)
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle")
                .resizable()
                .foregroundColor(.gray)
                .frame(width: 80, height: 80)
        }
    }
}

#Preview {
    let imageData = UIImage(named: "Salem")?.pngData()
    ProfileImageView(imageData: imageData)
}
