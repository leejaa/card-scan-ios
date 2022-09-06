//
//  scantest2_iosApp.swift
//  scantest2-ios
//
//  Created by break on 2022/09/06.
//

import SwiftUI

@main
struct scantest2_iosApp: App {
    @StateObject var vm = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
//                .onAppear {
//                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
//                }
        }
    }
}
