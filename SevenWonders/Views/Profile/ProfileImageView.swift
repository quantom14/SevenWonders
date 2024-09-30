//
//  ProfileImageView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 30/09/2024.
//

import SwiftUI

struct ProfileImageView: View {
    var imageData: Data?

    var body: some View {
        if let imageData = imageData, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
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
    let image = UIImage(named: "Salem")!.pngData()
    ProfileImageView(imageData: image)
}
