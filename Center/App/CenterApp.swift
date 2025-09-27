//
//  CenterApp.swift
//  Center
//
//  Created by Peter Bidoshi on 9/10/25.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct CenterApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var authManager = AuthManager.shared
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(authManager)
        }
    }
}
