//
//  AuthManager.swift
//  Center
//
//  Created by Jidong Zheng on 9/26/25.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

@Observable
@MainActor
class AuthManager {
    
    var authState: AuthState = .undefined
    private var authStateListener: AuthStateDidChangeListenerHandle?
    
    func startListeningToAuthState() async {
        authStateListener = Auth.auth().addStateDidChangeListener {_, user in
            self.authState = user != nil ? .authenticated : .notAuthenticated
        }
    }
    
    func signIn() async throws {
        guard let rootViewController = UIApplication.shared.firstKeyWindow?.rootViewController else { return }
        
        // grab client ID from firebase app
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration
        
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        
        // Get credential for firebase
        guard let idToken = result.user.idToken?.tokenString else { return }
        let accessToken = result.user.accessToken.tokenString
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        try await Auth.auth().signIn(with: credentials)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
}
