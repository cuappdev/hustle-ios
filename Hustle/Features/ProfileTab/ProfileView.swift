//
//  ProfileView.swift
//  Hustle
//
//  Created by Jay on 11/30/25.
//

import ComposableArchitecture
import SwiftUI

struct ProfileView: View {
    @Bindable var store: StoreOf<ProfileFeature>
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 40))
                .foregroundColor(DesignConstants.Colors.hustleGreen)
            Text("Profile coming soon")
                .font(DesignConstants.Fonts.title2)
                .foregroundColor(DesignConstants.Colors.primary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DesignConstants.Colors.wash)
    }
}

#Preview {
    ProfileView(
        store: Store(
            initialState: ProfileFeature.State(),
            reducer: { ProfileFeature() }
        )
    )
}
