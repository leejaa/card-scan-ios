//
//  ImagePicker.swift
//  SwiftUIImagePicker
//
//  Created by Simon Ng on 10/6/2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseStorage

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var isCompleteImageUpload: Bool
    @Binding var selectedImage: UIImage?
    @Binding var imagePicker: UIImagePickerController
    @Binding var imageUrl: String
    
    @Environment(\.presentationMode) private var presentationMode
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        imagePicker.showsCameraControls = false
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func onSuccess(url: String) {
            parent.isCompleteImageUpload = true
            
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image

                let storage = Storage.storage()
                
                var formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                let fileName = formatter.string(from: Date())
                // Create a storage reference
                let storageRef = storage.reference().child("images/\(fileName).jpg")
                
                let ref = storageRef.child("images/\(fileName).jpg")

                // Resize the image to 200px with a custom extension
        //        let resizedImage = image.aspectFittedToHeight(200)

                // Convert the image into JPEG and compress the quality to reduce its size
                let data = image.jpegData(compressionQuality: 0.2)

                // Change the content type to jpg. If you don't, it'll be saved as application/octet-stream type
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpg"

                // Upload the image
                if let data = data {
                    storageRef.putData(data, metadata: metadata) { (metadata, error) in
                        if let error = error {
                            print("Error while uploading file: ", error)
                        }
                        
                        if let metadata = metadata {
                            print("업로드 완료....")

                            storageRef.downloadURL { (url, error) in
                                guard let downloadURL = url else {
                                  // Uh-oh, an error occurred!
                                  return
                                }
                                print("downloadURL: \(downloadURL)")
                                self.parent.imageUrl = "\(downloadURL)"
                                self.parent.isCompleteImageUpload = true
                            }
                        }
                    }
                }
            }
//            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

