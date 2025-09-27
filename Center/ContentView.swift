//
//  ContentView.swift
//  Center
//
//  Created by Peter Bidoshi on 9/10/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(AuthManager.self) private var authManager
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Sign out"){
                signOut()
            }
        }
        .padding()
    }
    
    func signOut() {
        do {
            try authManager.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}
