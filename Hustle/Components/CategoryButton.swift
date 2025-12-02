//
//  CategoryButton.swift
//  Hustle
//
//  Created by Jay on 11/30/25.
//

import SwiftUI

struct CategoryButton: View {
    let category: Category
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: category.systemImage)
                    .font(.system(size: 16, weight: .semibold))
                Text(category.title)
                    .font(DesignConstants.Fonts.title3)
                    .fixedSize(horizontal: true, vertical: false)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            .frame(height: 32)
            .background(isSelected ? DesignConstants.Colors.hustleGreen : DesignConstants.Colors.white)
            .foregroundStyle(isSelected ? DesignConstants.Colors.white : DesignConstants.Colors.hustleGreen)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(DesignConstants.Colors.hustleGreen, lineWidth: 1.2)
            )
            .cornerRadius(20)
        }
        .buttonStyle(.plain)
        .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
    }
}
