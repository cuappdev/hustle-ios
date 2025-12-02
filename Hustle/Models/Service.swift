//
//  Service.swift
//  Hustle
//
//  Created by Jay on 11/30/25.
//

import Foundation

struct Service: Equatable, Identifiable, Codable {
    let id: UUID
    let providerPFP: String
    let providerName: String
    let description: String
    let price: String
    let rating: Double
}

struct ServiceSection: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let items: [Service]
}
