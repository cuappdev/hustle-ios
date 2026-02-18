//
//  TaggedView.swift
//  Hustle
//
//  Created by Jay on 12/6/25.
//

import SwiftUI

struct TaggedView: View {
    let title: String
    let services: [Service]
    let onBack: () -> Void
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                header
                FilterChipsRow(filters: ["Price", "Location", "Ratings"])
                ServiceResultsList(services: services, imageHeight: 240)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
        }
        .background(DesignConstants.Colors.white.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var header: some View {
        Text(title)
            .font(DesignConstants.Fonts.h3)
            .foregroundColor(DesignConstants.Colors.black)
            .frame(maxWidth: .infinity)
            .overlay(alignment: .leading) {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(DesignConstants.Colors.black)
                        .padding(.leading, 16)
                        .contentShape(Rectangle())
                }
            }
            .padding(.top, 8)
    }
}

#Preview {
    TaggedView(
        title: "Lessons",
        services: SampleData.services,
        onBack: {}
    )
}
