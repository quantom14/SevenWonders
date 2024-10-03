//
//  ProfileImagePickerView.swift
//  SevenWonders
//
//  Created by Tom Bintener on 01/10/2024.
//

import SwiftUI
import UIKit

struct ProfileImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage? // A binding to hold the selected image
    @Binding var isPresented: Bool // A binding to show/dismiss the image picker
        
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ProfileImagePickerView
            
        init(_ parent: ProfileImagePickerView) {
            self.parent = parent
        }
            
        // Handle image selection
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            // Check if an image was selected and assign it to the bound variable
            if let selectedEditedImage = info[.editedImage] as? UIImage {
                parent.selectedImage = selectedEditedImage
            }
            // Dismiss the picker
            parent.isPresented = false
        }
            
        // Handle image picker cancellation
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
        
    // Make the Coordinator
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
        
    // Create and configure the UIImagePickerController
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
        
    // Update the UIImagePickerController
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

#Preview {
    @Previewable @State var imageData: UIImage? = nil
    @Previewable @State var isPresented = true
    ProfileImagePickerView(selectedImage: $imageData, isPresented: $isPresented)
}
