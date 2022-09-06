//
//  ContentView.swift
//  scantest-ios
//
//  Created by break on 2022/09/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: CameraView()) {
                    Text("카드스캔")
                }
            }
                .navigationBarTitle("홈화면")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
