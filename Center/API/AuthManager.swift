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
    
    // MARK: - Singleton Instance
    static let shared = AuthManager()
    
    // MARK: - Properties
    var authState: AuthState = .undefined
    var user: FirebaseAuth.User?
    private var authStateListener: AuthStateDidChangeListenerHandle?
    
    
    // MARK: Init
    private init() {}
    
    func startListeningToAuthState() async {
        authStateListener = Auth.auth().addStateDidChangeListener {_, user in
            self.authState = user != nil ? .authenticated : .notAuthenticated
            self.user = user
        }
    }
    
    func signIn() async throws {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
            throw GoogleAuthError.noPresentingViewController
        }
    
        let GIDSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController)
        try await getCredentialsFromGoogleUser(user: GIDSignInResult.user)
    }
    
    func getCredentialsFromGoogleUser(user: GIDGoogleUser) async throws {
        
        guard let idToken = user.idToken?.tokenString else {
            throw GoogleAuthError.noIDToken
        }
        let accessToken = user.accessToken.tokenString
        
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        let authResult = try await Auth.auth().signIn(with: credentials)
        
        self.user = authResult.user
    }
    
    func refreshSignInIfNeeded() async throws {
        // Restore previous sign-in
        if GIDSignIn.sharedInstance.currentUser == nil {
            try await GIDSignIn.sharedInstance.restorePreviousSignIn()
        }
        
        // Get curret user or throw error
        guard let currentUser = GIDSignIn.sharedInstance.currentUser else {
            throw GoogleAuthError.noUserSignedIn
        }
        
        // Refresh tokens
        try await currentUser.refreshTokensIfNeeded()
        try await getCredentialsFromGoogleUser(user: currentUser)
        
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        
        do{
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
        
        self.user = nil
    }
}

enum GoogleAuthError: Error, LocalizedError {
    case noUserSignedIn
    case noPresentingViewController
    case noIDToken
    
    var errorDescription: String? {
        switch self {
        case .noUserSignedIn:
            return "No user is currently signed in"
        case .noPresentingViewController:
            return "Unable to present sign-in interface"
        case .noIDToken:
            return "Google ID token not available"
        }
    }
}
