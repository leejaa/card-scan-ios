//
//  ResultView.swift
//  scantest2-ios
//
//  Created by break on 2022/09/06.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var webViewModel = WebViewModel()
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack {
            WebView(url: "https://brg-test.vercel.app/webview?imageUrl=\(vm.imageUrl)", viewModel: webViewModel)
        }
    }
}
