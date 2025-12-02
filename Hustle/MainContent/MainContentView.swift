//
//  MainView.swift
//  Center
//
//  Created by Jidong Zheng on 9/26/25.
//

import ComposableArchitecture
import SwiftUI

struct MainContentView: View {
    @Bindable var store: StoreOf<MainContentFeature>
    
    var body: some View {
        TabView(selection: $store.selectedTab) {
            HomeView(store: store.scope(state: \.home, action: \.home))
                .tabItem {
                    Label(MainContentFeature.Tab.home.title, systemImage: MainContentFeature.Tab.home.systemImage)
                }
                .tag(MainContentFeature.Tab.home)
            
            LearnView(store: store.scope(state: \.learn, action: \.learn))
                .tabItem {
                    Label(MainContentFeature.Tab.learn.title, systemImage: MainContentFeature.Tab.learn.systemImage)
                }
                .tag(MainContentFeature.Tab.learn)
            
            MessagesView(store: store.scope(state: \.messages, action: \.messages))
                .tabItem {
                    Label(MainContentFeature.Tab.messages.title, systemImage: MainContentFeature.Tab.messages.systemImage)
                }
                .tag(MainContentFeature.Tab.messages)
            
            ProfileView(store: store.scope(state: \.profile, action: \.profile))
                .tabItem {
                    Label(MainContentFeature.Tab.profile.title, systemImage: MainContentFeature.Tab.profile.systemImage)
                }
                .tag(MainContentFeature.Tab.profile)
        }
        .accentColor(DesignConstants.Colors.hustleGreen)
    }
}

#Preview {
    MainContentView(
        store: Store(
            initialState: MainContentFeature.State(),
            reducer: { MainContentFeature() }
        )
    )
}
