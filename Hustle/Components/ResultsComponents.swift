//
//  ResultsComponents.swift
//  Hustle
//
//  Created by Jay on 12/6/25.
//

import SwiftUI

struct FilterChipsRow: View {
    let filters: [String]
    var includeFilterIcon: Bool = false
    
    var body: some View {
        HStack(spacing: 8) {
            Image("Filter")
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(DesignConstants.Colors.hustleGreen.opacity(0.5), lineWidth: 1)
                )
            
            ForEach(filters, id: \.self) { filter in
                HStack(spacing: 6) {
                    Text(filter)
                        .font(DesignConstants.Fonts.title3Bold)
                        .foregroundColor(DesignConstants.Colors.hustleGreen)
                    Image(systemName: "chevron.down")
                        .font(DesignConstants.Fonts.title3Bold)
                        .foregroundColor(DesignConstants.Colors.hustleGreen)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(DesignConstants.Colors.hustleGreen.opacity(0.5), lineWidth: 1)
                )
            }
        }
        .padding(.bottom, 16)
        .padding(.top, 8)
    }
}

struct ServiceResultsList: View {
    let services: [Service]
    var imageHeight: CGFloat = 240
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(services) { service in
                ServiceCardLarge(
                    service: service,
                    isFavorite: false,
                )
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    VStack(spacing: 24) {
        FilterChipsRow(filters: ["Price", "Location", "Ratings"], includeFilterIcon: true)
            .padding(.horizontal, 16)
        
        ServiceResultsList(services: SampleData.services, imageHeight: 180)
            .padding(.horizontal, 16)
    }
}
