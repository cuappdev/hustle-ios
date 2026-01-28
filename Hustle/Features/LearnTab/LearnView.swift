//
//  LearnView.swift
//  Hustle
//
//  Created by Jay on 11/30/25.
//

import ComposableArchitecture
import SwiftUI

struct LearnView: View {
    @Bindable var store: StoreOf<LearnFeature>
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "graduationcap.fill")
                .font(.system(size: 40))
                .foregroundColor(DesignConstants.Colors.hustleGreen)
            Text("Learn tab coming soon")
                .font(DesignConstants.Fonts.title2)
                .foregroundColor(DesignConstants.Colors.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DesignConstants.Colors.white)
    }
}

#Preview {
    LearnView(
        store: Store(
            initialState: LearnFeature.State(),
            reducer: { LearnFeature() }
        )
    )
}
