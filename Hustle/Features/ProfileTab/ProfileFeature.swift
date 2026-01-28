//
//  ProfileFeature.swift
//  Hustle
//
//  Created by Jay on 11/30/25.
//

import ComposableArchitecture

@Reducer
struct ProfileFeature {
    @ObservableState
    struct State: Equatable {}
    
    enum Action: Equatable {
        case logoutTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            case .logoutTapped:
                return .none
            }
        }
    }
}
