//
//  SearchFeature.swift
//  Hustle
//
//  Created by Jay on 12/4/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct SearchFeature {
    @ObservableState
    struct State: Equatable {
        var query = ""
        var isShowingResults = false
        var recentQueries: [String] = SampleData.searchRecentQueries
        var recentServices: [Service] = SampleData.searchRecentServices
        var searchResults: [Service] = []
        var hasSearched = false
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case searchSubmitted
        case resetSearch
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .resetSearch:
                state.query = ""
                state.hasSearched = false
                state.searchResults = []
                state.isShowingResults = false
                return .none
                
            case .searchSubmitted:
                let trimmed = state.query.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmed.isEmpty else {
                    state.hasSearched = false
                    state.searchResults = []
                    state.isShowingResults = false
                    return .none
                }
                
                // Update recent queries (dedup, most recent first, max 10)
                state.recentQueries.removeAll { $0.caseInsensitiveCompare(trimmed) == .orderedSame }
                state.recentQueries.insert(trimmed, at: 0)
                if state.recentQueries.count > 10 {
                    state.recentQueries = Array(state.recentQueries.prefix(10))
                }
                
                // Filter sample services by words contained in description or category
                let tokens = trimmed
                    .lowercased()
                    .split(whereSeparator: \.isWhitespace)

                state.searchResults = SampleData.services.filter { service in
                    let description = service.description.lowercased()
                    let category = service.category.lowercased()
                    return tokens.allSatisfy { token in
                        let bare = token.hasSuffix("s") ? String(token.dropLast()) : String(token)
                        return description.contains(token)
                        || description.contains(bare)
                        || category.contains(token)
                        || category.contains(bare)
                    }
                }

                state.hasSearched = true
                state.isShowingResults = true
                return .none
            }
        }
    }
}
