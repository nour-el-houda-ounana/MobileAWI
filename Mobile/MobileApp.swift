//
//  MobileApp.swift
//  Mobile
//
//  Created by m1 on 02/03/2022.
//

import SwiftUI
import Firebase

@main
struct MobileApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
