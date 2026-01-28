//
//  SearchResultsView.swift
//  Hustle
//
//  Created by Jay on 12/5/25.
//

import ComposableArchitecture
import SwiftUI

struct SearchResultsView: View {
    @Bindable var store: StoreOf<SearchFeature>
    @FocusState private var isSearchFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            
            header
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 16)
            
            if store.searchResults.isEmpty {
                noResultsView
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    FilterChipsRow(filters: ["Price", "Location", "Ratings"], includeFilterIcon: true)
                        .padding(.horizontal, 16)
                    
                    ServiceResultsList(services: store.searchResults, imageHeight: 240)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 32)
                }
                .scrollDismissesKeyboard(.interactively)
            }
        }
        .background(DesignConstants.Colors.white.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            isSearchFieldFocused = false
        }
    }
    
    private var header: some View {
        HStack(spacing: 12) {
            Button {
                store.send(.binding(.set(\.isShowingResults, false)))
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(DesignConstants.Colors.black)
            }
            
            TextField(
                "",
                text: $store.query,
                prompt: Text("Search services")
                    .foregroundStyle(DesignConstants.Colors.wash)
            )
            .onSubmit {
                store.send(.searchSubmitted)
            }
            .focused($isSearchFieldFocused)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(DesignConstants.Colors.shadedGray)
            )
            .foregroundColor(DesignConstants.Colors.black)
            .tint(DesignConstants.Colors.black)
            .submitLabel(.search)
        }
        .frame(height: 28)
    }
    
    private var noResultsView: some View {
        VStack(alignment: .center, spacing: 16) { // Added spacing for better layout
            Spacer()
            
            Image("SadFace")
                .font(.system(size: 60)) // Made icon bigger
            
            VStack(spacing: 8) {
                Text("No Results Found")
                    .font(DesignConstants.Fonts.h2Italic)
                    .foregroundColor(DesignConstants.Colors.hustleGreen)
                Text("No results found. Please try again.")
                    .font(DesignConstants.Fonts.body2)
                    .foregroundColor(DesignConstants.Colors.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Button {
                store.send(.resetSearch)
            } label: {
                Text("Go Back")
                    .font(DesignConstants.Fonts.h3)
                    .foregroundColor(DesignConstants.Colors.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        Capsule()
                            .fill(DesignConstants.Colors.hustleGreen)
                    )
            }
            .padding(.horizontal, 32)
            .padding(.top, 16)
            
            Spacer()
            
            Spacer().frame(height: 50)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        SearchResultsView(
            store: Store(
                initialState: SearchFeature.State(
                    query: "photos",
                    isShowingResults: true,
                    searchResults: SampleData.searchResults,
                    hasSearched: true
                ),
                reducer: { SearchFeature() }
            )
        )
    }
}
