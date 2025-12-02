//
//  AppFeature.swift
//  Center
//
//  Created by Jidong Zheng on 10/19/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable {
        var auth = AuthFeature.State()
        var main = MainContentFeature.State()
        var isAuthenticated = false
    }
    
    enum Action {
        case auth(AuthFeature.Action)
        case main(MainContentFeature.Action)
        case onAppear
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.auth, action: \.auth) {
            AuthFeature()
        }
        
        Scope(state: \.main, action: \.main) {
            MainContentFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .auth(.authenticationSucceeded):
                state.isAuthenticated = true
                return .none
                
            case .auth(.authenticationFailed):
                state.isAuthenticated = false
                return .none
                
            case .auth:
                return .none
                
            case .main:
                return .none
            }
        }
    }
}
