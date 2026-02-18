//
//  ContentView.swift
//  Center
//
//  Created by Jidong Zheng on 10/20/25.
//

import ComposableArchitecture
import SwiftUI
import ComposableArchitecture
import SwiftUI

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    @Bindable var store: StoreOf<HomeFeature>
    
    var body: some View {
        NavigationStack {
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
            .navigationDestination(isPresented: $store.isShowingSearch) {
                SearchView(store: store.scope(state: \.search, action: \.search))
            }
            .navigationDestination(isPresented: $store.isShowingTagged) {
                TaggedView(
                    title: store.selectedTaggedTitle,
                    services: store.taggedServices
                ) {
                    store.isShowingTagged = false
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await store.send(.task).finish()
        }
    }
    
    private var searchBar: some View {
        Button {
            store.isShowingSearch = true
        } label: {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(DesignConstants.Colors.wash)
                
                Text("Find a service")
                    .font(DesignConstants.Fonts.body2)
                    .foregroundColor(DesignConstants.Colors.wash)
                
                Spacer()
            }
            .padding(.horizontal, 12)
            .frame(height: 40)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(DesignConstants.Colors.shadedGray)
            )
        }
        .buttonStyle(.plain)
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
            
            Button {
                store.selectedTaggedTitle = section.title
                store.taggedServices = section.items
                store.isShowingTagged = true
            } label: {
                HStack {
                    Text(section.title)
                        .font(DesignConstants.Fonts.h3)
                        .foregroundColor(DesignConstants.Colors.black)
                        .padding(.leading, 16)
                        .padding(.trailing, 12)
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(DesignConstants.Colors.black)
                        .font(.system(size: 16, weight: .semibold))
                }
                .padding(.vertical, 8)
            }
            .buttonStyle(.plain)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(section.items.enumerated()), id: \.element.id) { index, service in
                        ServiceCard(
                            service: service,
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
