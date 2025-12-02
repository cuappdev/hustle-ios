//
//  ContentView.swift
//  Center
//
//  Created by Jidong Zheng on 10/20/25.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    @Bindable var store: StoreOf<HomeFeature>
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("Hustle")
                    .font(DesignConstants.Fonts.h2Italic)
                    .foregroundColor(DesignConstants.Colors.hustleGreen)
                    .padding(.horizontal, 16)
                
                searchBar
                    .padding(.horizontal, 16)
                categoryRow
                
                ForEach(store.sections) { section in
                    sectionView(for: section)
                }
            }
            .contentMargins(.horizontal, 16)
        }
        .background(DesignConstants.Colors.white.ignoresSafeArea())
        .task {
            await store.send(.task).finish()
        }
    }
    
    private var searchBar: some View {
        HStack() {
            Image(systemName: "magnifyingglass")
                .foregroundColor(DesignConstants.Colors.wash)
                .padding(.leading, 12)
            
            TextField("Find a service", text: $store.searchQuery)
                .frame(height: 32)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(DesignConstants.Colors.shadedGray)
        )
        
    }
    
    private var categoryRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(store.categories) { category in
                    CategoryButton(
                        category: category,
                        isSelected: store.selectedCategoryID == category.id
                    ) {
                        store.send(.categoryTapped(category.id))
                    }
                }
            }
            .padding(.vertical, 4)
        }
    }
    
    private func sectionView(for section: ServiceSection) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(section.title)
                    .font(DesignConstants.Fonts.h3)
                    .foregroundColor(DesignConstants.Colors.primary)
                    .padding(.leading, 16)
                    .padding(.trailing, 12)
                
                Image(systemName: "chevron.right")
                    .foregroundColor(DesignConstants.Colors.primary)
                    .font(.system(size: 16, weight: .semibold))
                
                
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(section.items.enumerated()), id: \.element.id) { index, service in
                        ServiceCard(
                            service: service,
                            // TODO: Implement logic for favoriting
                            isFavorite: index % 2 == 0
                        )
                    }
                }
            }
        }
        .padding(.bottom, 12)
    }
}

#Preview {
    HomeView(
        store: Store(
            initialState: HomeFeature.State(),
            reducer: { HomeFeature() }
        )
    )
}
