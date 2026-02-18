//
//  ServiceCard.swift
//  Hustle
//
//  Created by Jay on 11/30/25.
//

import SwiftUI

struct ServiceCardLarge: View {
    let service: Service
    var isFavorite: Bool = false
    var cardWidth: CGFloat? = 364
    var cardHeight: CGFloat? = 436
    var imageHeight: CGFloat = 360
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(service.serviceImage)
                .resizable()
                .scaledToFill()
                .frame(width: cardWidth, height: imageHeight)
                .clipped()
            
            Spacer()
            
            HStack{
                Image(service.providerPFP)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack{
                    HStack{
                        Text(service.providerName)
                            .font(DesignConstants.Fonts.title3Bold)
                            .foregroundColor(DesignConstants.Colors.black)
                            .lineLimit(1)
                        Spacer()
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(DesignConstants.Colors.accentGreen)
                            .font(.system(size: 16))
                        
                        Text(String(format: "%.1f", service.rating))
                            .font(DesignConstants.Fonts.subtitle1)
                            .foregroundColor(DesignConstants.Colors.secondaryGrey)
                    }
                    
                    HStack{
                        Text(service.description)
                            .font(DesignConstants.Fonts.title4)
                            .foregroundColor(DesignConstants.Colors.secondaryGrey)
                            .lineLimit(1)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(service.price)
                            .font(DesignConstants.Fonts.title4)
                            .foregroundColor(DesignConstants.Colors.secondaryGrey)
                    }
                }
            }
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .frame(width: cardWidth, height: cardHeight, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(DesignConstants.Colors.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(DesignConstants.Colors.stroke, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 4)
    }
}
