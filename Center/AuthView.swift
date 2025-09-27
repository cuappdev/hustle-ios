//
//  AuthView.swift
//  Center
//
//  Created by Jidong Zheng on 9/26/25.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthView: View {
    
    @Environment(AuthManager.self) private var authManager
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: signIn) {
                Text("Log in with NetID")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            
            Spacer()
        }
        .padding()
    }
    
    func signIn() {
        Task {
            do {
                try await authManager.signIn()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    AuthView()
}
