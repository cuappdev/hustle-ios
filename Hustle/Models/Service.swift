//
//  Service.swift
//  Hustle
//
//  Created by Jay on 11/30/25.
//

import Foundation

struct Service: Equatable, Identifiable, Codable {
    let id: UUID
    let providerName: String
    let description: String
    let price: String
    let rating: Double
    
    
    // Dummy
    static var dummy: [Service] =
        [
            .init(id: UUID(), providerName: "Lauren Ah-Hot", description: "Dreamy fall grad photo session", price: "From $67/hour", rating: 4.1),
            .init(id: UUID(), providerName: "Peter B", description: "Calculus Tutoring", price: "From $30/hour", rating: 4.8),
        ]
    
}

struct ServiceSection: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let items: [Service]
}
