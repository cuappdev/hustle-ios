//
//  File.swift
//  Hustle
//
//  Created by Jay on 11/30/25.
//

import Foundation

struct Category: Equatable, Identifiable {
    let id: String
    let title: String
    let systemImage: String // Assuming backend sends an icon name, or you map it locally
}

