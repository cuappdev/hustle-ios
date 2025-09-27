//
//  MainView.swift
//  Center
//
//  Created by Jidong Zheng on 9/26/25.
//

import SwiftUI

struct MainView: View {
    
    @Environment(AuthManager.self) private var authManager
    
    var body: some View {
        Group {
            switch authManager.authState {
            case .undefined:
                ProgressView()
            case .authenticated:
                ContentView()
            case .notAuthenticated:
                AuthView()
            }
        }
        .task {
            await authManager.startListeningToAuthState()
        }
        
    }
}

#Preview {
    ContentView()
}

