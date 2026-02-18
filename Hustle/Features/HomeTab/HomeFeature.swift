//
//  HomeFeature.swift
//  Hustle
//
//  Created by Jay on 11/30/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HomeFeature {
    
    @ObservableState
    struct State: Equatable {
        var searchQuery = ""
        var isShowingSearch = false
        var isShowingTagged = false
        var selectedTaggedTitle: String = ""
        var taggedServices: [Service] = []
        var search = SearchFeature.State()
        var categories: [Category] = []
        var selectedCategoryID: Category.ID?
        var sections: [ServiceSection] = []
        var isLoading = false
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case task
        case categoryTapped(Category.ID)
        case search(SearchFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Scope(state: \.search, action: \.search) {
            SearchFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .task:
                state.isLoading = true
                state.categories = SampleData.categories
                state.sections = SampleData.sections
                state.isLoading = false
                return .none
                
            case let .categoryTapped(id):
                state.selectedCategoryID = state.selectedCategoryID == id ? nil : id
                
                if let category = state.categories.first(where: { $0.id == id }) {
                    state.selectedTaggedTitle = category.title
                    state.taggedServices = SampleData.services.filter { $0.category == category.id }
                    state.isShowingTagged = true
                    return .none
                }
                return .none
                
            case .binding, .search:
                return .none
            }
        }
    }
}
