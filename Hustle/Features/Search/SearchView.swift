//
//  SearchView.swift
//  Hustle
//
//  Created by Jay on 12/4/25.
//

import ComposableArchitecture
import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var store: StoreOf<SearchFeature>
    @FocusState private var isSearchFieldFocused: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                header
                    .padding(.top, 20)
                
                recentSection
                
                Text("Recently viewed")
                    .font(DesignConstants.Fonts.h3)
                    .foregroundColor(DesignConstants.Colors.black)
                
                recentServices
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
        }
        .scrollDismissesKeyboard(.interactively)
        .background(DesignConstants.Colors.white.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            isSearchFieldFocused = true
        }
        .onDisappear {
            isSearchFieldFocused = false
        }
        .navigationDestination(isPresented: $store.isShowingResults) {
            SearchResultsView(store: store)
        }
    }
    
    private var header: some View {
        HStack(spacing: 12) {
            Button(action: { dismiss() }) {
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
    
    private var recentSection: some View {
        VStack(alignment: .leading) {
            Text("Recent")
                .font(DesignConstants.Fonts.h3)
                .foregroundColor(DesignConstants.Colors.black)
            
            let limitedQueries = Array(store.recentQueries.prefix(10))
            VStack(spacing: 0) {
                ForEach(Array(limitedQueries.enumerated()), id: \.offset) { index, query in
                    Button {
                        store.query = query
                        store.send(.searchSubmitted)
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "clock.arrow.circlepath")
                                .foregroundColor(DesignConstants.Colors.hustleGreen)
                                .font(.system(size: 18, weight: .regular))
                            
                            Text(query)
                                .font(DesignConstants.Fonts.body2)
                                .foregroundColor(DesignConstants.Colors.black)
                            
                            Spacer()
                        }
                        .padding(.vertical, 12)
                    }
                    .buttonStyle(.plain)
      
                    if index < limitedQueries.count - 1 {
                        Divider()
                            .background(DesignConstants.Colors.stroke)
                    }
                }
            }
        }
    }
    
    private var recentServices: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Array(store.recentServices.prefix(5))) { service in
                    ServiceCard(
                        service: service
                    )
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchView(
            store: Store(
                initialState: SearchFeature.State(),
                reducer: { SearchFeature() }
            )
        )
    }
}
