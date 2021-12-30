//
//  collaborativeCBTApp.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/05.
//

import SwiftUI
import Firebase

@main
struct collaborativeCBTApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            CustomTabView()
                .preferredColorScheme(.light)
        }
    }
}
