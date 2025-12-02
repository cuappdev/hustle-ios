//
//  MessagesView.swift
//  Hustle
//
//  Created by Jay on 11/30/25.
//

import ComposableArchitecture
import SwiftUI

struct MessagesView: View {
    @Bindable var store: StoreOf<MessagesFeature>
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "bubble.left.and.bubble.right.fill")
                .font(.system(size: 40))
                .foregroundColor(DesignConstants.Colors.hustleGreen)
            Text("Messages coming soon")
                .font(DesignConstants.Fonts.title2)
                .foregroundColor(DesignConstants.Colors.primary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DesignConstants.Colors.wash)
    }
}

#Preview {
    MessagesView(
        store: Store(
            initialState: MessagesFeature.State(),
            reducer: { MessagesFeature() }
        )
    )
}
