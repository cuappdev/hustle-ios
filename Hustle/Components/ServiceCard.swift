//
//  ServiceCard.swift
//  Hustle
//
//  Created by Jay on 11/30/25.
//

import SwiftUI

struct ServiceCard: View {
    let service: Service
    var isFavorite: Bool = false
    var cardWidth: CGFloat? = 178
    var cardHeight: CGFloat? = 280
    var imageHeight: CGFloat = 178
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                Image(service.serviceImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: cardWidth, height: imageHeight)
                    .clipped()
                
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? Color.red : Color.white)
                    .padding(10)
                    .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 4)
            }
            
            VStack(alignment: .leading){
                HStack{
                    Image(service.providerPFP)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .clipShape(Circle())
                    
                    Text(service.providerName)
                        .font(DesignConstants.Fonts.title3Bold)
                        .foregroundColor(DesignConstants.Colors.black)
                        .lineLimit(1)
                }
                
                Text(service.description)
                    .font(DesignConstants.Fonts.title4)
                    .foregroundColor(DesignConstants.Colors.black)
                    .lineLimit(2, reservesSpace: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack{
                    Text(service.price)
                        .font(DesignConstants.Fonts.title3)
                        .foregroundColor(DesignConstants.Colors.black)
                    
                    Spacer()
                    
                    HStack() {
                        Image(systemName: "star.fill")
                            .foregroundColor(DesignConstants.Colors.accentGreen)
                            .font(.system(size: 16))
                        
                        Text(String(format: "%.1f", service.rating))
                            .font(DesignConstants.Fonts.subtitle1)
                            .foregroundColor(DesignConstants.Colors.black)
                    }
                }
                
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 16)
            
        }
        .frame(width: cardWidth, height: cardHeight, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(DesignConstants.Colors.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(DesignConstants.Colors.stroke, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 4)
    }
}
