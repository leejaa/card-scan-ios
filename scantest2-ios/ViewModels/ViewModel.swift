//
//  ViewModel.swift
//  scantest-ios
//
//  Created by break on 2022/09/02.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var showPicker = true
    @Published var source: Picker.Source = .library
    @Published var imagePicker = UIImagePickerController()
    @Published var isCompleteImageUpload = false
    @Published var imageUrl: String = ""
    
    func showPhotoPicker() {
        if source == .camera {
            if !Picker.checkPermissions() {
                print("There is no camera on this device")
                return
            }
        }
        showPicker = true
    }
}
