//
//  MainContentFeature.swift
//  Hustle
//
//  Created by Jay on 11/30/25.
//

import ComposableArchitecture

@Reducer
struct MainContentFeature {
    
    @ObservableState
    struct State: Equatable {
        var selectedTab: Tab = .home
        var home = HomeFeature.State()
        var learn = LearnFeature.State()
        var messages = MessagesFeature.State()
        var profile = ProfileFeature.State()
    }
    
    enum Tab: Hashable {
        case home
        case learn
        case messages
        case profile
        
        var title: String {
            switch self {
            case .home: return "Home"
            case .learn: return "Learn"
            case .messages: return "Messages"
            case .profile: return "Profile"
            }
        }
        
        var systemImage: String {
            switch self {
            case .home: return "house.fill"
            case .learn: return "graduationcap.fill"
            case .messages: return "bubble.left.and.bubble.right.fill"
            case .profile: return "person.crop.circle.fill"
            }
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case home(HomeFeature.Action)
        case learn(LearnFeature.Action)
        case messages(MessagesFeature.Action)
        case profile(ProfileFeature.Action)
        case tabTapped(Tab)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.home, action: \.home) {
            HomeFeature()
        }
        Scope(state: \.learn, action: \.learn) {
            LearnFeature()
        }
        Scope(state: \.messages, action: \.messages) {
            MessagesFeature()
        }
        Scope(state: \.profile, action: \.profile) {
            ProfileFeature()
        }
        
        Reduce { state, action in
            switch action {
            case let .tabTapped(tab):
                state.selectedTab = tab
                return .none
            case .binding, .home, .learn, .messages, .profile:
                return .none
            }
        }
    }
}
