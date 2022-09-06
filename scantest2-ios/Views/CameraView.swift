//
//  CameraView.swift
//  scantest-ios
//
//  Created by break on 2022/09/02.
//

import SwiftUI

struct CameraView: View {
    @EnvironmentObject var vm: ViewModel
    var showPicker = false
    
    var body: some View {
        VStack {
            Text("카드이미지를 사이즈에 맞춰주세요")
                .padding(20)
            ZStack {
                Rectangle()
                    .stroke(.black)
                    .frame(width: 250, height: 350)
                    .padding(15)

                ImagePicker(sourceType: .camera, selectedImage: $vm.image, imagePicker: $vm.imagePicker).frame(width: 250, height: 350)
            }
            Button(action: {
                vm.imagePicker.takePicture()
            }) {
                Text("카드스캔")
            }
             Spacer()
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
