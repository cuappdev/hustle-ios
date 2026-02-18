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
        VStack(spacing: 20) {
            VStack(spacing: 12) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(DesignConstants.Colors.hustleGreen)
                Text("Profile coming soon")
                    .font(DesignConstants.Fonts.title2)
                    .foregroundColor(DesignConstants.Colors.black)
            }
            
            Button {
                store.send(.logoutTapped)
            } label: {
                Text("Log out")
                    .font(DesignConstants.Fonts.title3Bold)
                    .foregroundColor(DesignConstants.Colors.white)
                    .frame(maxWidth: 220)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(DesignConstants.Colors.hustleGreen)
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DesignConstants.Colors.white)
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
