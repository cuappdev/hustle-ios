//
//  MessagesFeature.swift
//  Hustle
//
//  Created by Jay on 11/30/25.
//

import ComposableArchitecture

@Reducer
struct MessagesFeature {
    @ObservableState
    struct State: Equatable {}
    
    enum Action: Equatable {}
    
    var body: some ReducerOf<Self> {
        Reduce { _, _ in .none }
    }
}
