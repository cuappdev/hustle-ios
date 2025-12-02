//
//  AppView.swift
//  Hustle
//
//  Created by Jay on 11/30/25.
//

import ComposableArchitecture
import SwiftUI

struct AppView: View {
    @Bindable var store: StoreOf<AppFeature>
    
    var body: some View {
        Group {
            if store.isAuthenticated {
                MainContentView(store: store.scope(state: \.main, action: \.main))
            } else {
                AuthView(store: store.scope(state: \.auth, action: \.auth))
            }
        }
        .task {
            await store.send(.auth(.startListening)).finish()
        }
    }
}

#Preview {
    AppView(
        store: Store(
            initialState: AppFeature.State(),
            reducer: { AppFeature() }
        )
    )
}
