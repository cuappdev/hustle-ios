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
        var categories: [Category] = []
        var selectedCategoryID: Category.ID?
        var sections: [ServiceSection] = []
        var isLoading = false
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case task
        case categoryTapped(Category.ID)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .task:
                state.isLoading = true
                state.categories = Self.sampleCategories
                state.sections = Self.sampleSections
                state.isLoading = false
                return .none
                
            case let .categoryTapped(id):
                state.selectedCategoryID = state.selectedCategoryID == id ? nil : id
                return .none
                
            case .binding:
                return .none
            }
        }
    }
}

// MARK: - Sample Data
extension HomeFeature {
    static let sampleCategories: [Category] = [
        Category(id: "lessons", title: "Lessons", systemImage: "book.closed.fill"),
        Category(id: "photo", title: "Photo", systemImage: "camera.fill"),
        Category(id: "beauty", title: "Beauty", systemImage: "sparkles"),
        Category(id: "professional", title: "Professional Services", systemImage: "briefcase.fill"),
        Category(id: "homeCare", title: "Home Care", systemImage: "house.fill")
    ]
    
    static let sampleServices: [Service] = [
        Service(id: UUID(), providerPFP: "lauren", providerName: "Lauren Ah-Hot", description: "Dreamy fall grad photo session", price: "From $67/hour", rating: 4.1),
        Service(id: UUID(), providerPFP: "lauren", providerName: "Lauren Ah-Hot", description: "Dreamy fall grad photo session", price: "From $67/hour", rating: 4.1),
        Service(id: UUID(), providerPFP: "lauren", providerName: "Peter B", description: "Calculus tutoring", price: "From $30/hour", rating: 4.8),
        Service(id: UUID(), providerPFP: "lauren", providerName: "Caroline S", description: "Hair styling for events", price: "From $67/hour", rating: 4.6)
    ]
    
    static let sampleSections: [ServiceSection] = [
        ServiceSection(title: "Popular right now", items: Array(sampleServices.prefix(3))),
        ServiceSection(title: "New on Hustle", items: Array(sampleServices.suffix(3))),
        ServiceSection(title: "Service near your", items: Array(sampleServices.suffix(3))),
        ServiceSection(title: "Available this week", items: Array(sampleServices.suffix(3)))
    ]
}
