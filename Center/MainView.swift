//
//  MainView.swift
//  Center
//
//  Created by Jidong Zheng on 9/26/25.
//

import SwiftUI

struct MainView: View {
    
    
    var body: some View {
        Group {
            switch AuthManager.shared.authState {
            case .undefined:
                ProgressView()
            case .authenticated:
                ContentView()
            case .notAuthenticated:
                AuthView()
            }
        }
        .task {
            await AuthManager.shared.startListeningToAuthState()
        }
        
    }
}

#Preview {
    ContentView()
}

