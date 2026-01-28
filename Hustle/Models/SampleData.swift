//
//  SampleData.swift
//  Hustle
//
//  Created by Jay on 12/5/25.
//

import Foundation

enum SampleData {
    
    static let categories: [Category] = [
        Category(id: "lessons", title: "Lessons", systemImage: "book.closed.fill"),
        Category(id: "photo", title: "Photo", systemImage: "camera.fill"),
        Category(id: "beauty", title: "Beauty", systemImage: "sparkles"),
        Category(id: "professional", title: "Professional Services", systemImage: "briefcase.fill"),
        Category(id: "homeCare", title: "Home Care", systemImage: "house.fill")
    ]
    
    static let services: [Service] = [
        Service(id: UUID(), category: "photo", providerPFP: "Jay", providerName: "Jay Z.", serviceImage: "GradPhoto", description: "Dreamy fall grad photo session", price: "From $67/hour", rating: 4.1),
        Service(id: UUID(), category: "lessons", providerPFP: "Jay", providerName: "Jay Z.", serviceImage: "MathTutor", description: "Calculus tutoring", price: "From $30/hour", rating: 4.8),
        Service(id: UUID(), category: "beauty", providerPFP: "lauren", providerName: "Caroline S", serviceImage: "HairStyling", description: "Hair styling for events", price: "From $67/hour", rating: 4.6),
        Service(id: UUID(), category: "beauty", providerPFP: "lauren", providerName: "Mia Nguyen", serviceImage: "NailWork", description: "Gel manicure and nail art", price: "From $40/session", rating: 4.8),
        Service(id: UUID(), category: "beauty", providerPFP: "lauren", providerName: "Alex Fade", serviceImage: "Haircut", description: "Campus fades and haircuts", price: "From $35/service", rating: 4.7),
        Service(id: UUID(), category: "photo", providerPFP: "lauren", providerName: "Casey Lens", serviceImage: "GradPhotoGirls", description: "Portrait and event photography", price: "From $80/hour", rating: 4.9),
        Service(id: UUID(), category: "lessons", providerPFP: "lauren", providerName: "Devon Codes", serviceImage: "ProgrammingTutor", description: "Intro to programming tutoring", price: "From $45/hour", rating: 4.8),
        Service(id: UUID(), category: "beauty", providerPFP: "Jay", providerName: "Jay Z.", serviceImage: "Makeup", description: "Event-ready makeup looks", price: "From $90/session", rating: 4.6)
    ]
    
    static let sections: [ServiceSection] = [
        ServiceSection(title: "Popular right now", items: Array(services.prefix(3))),
        ServiceSection(title: "New on Hustle", items: Array(services.suffix(3))),
        ServiceSection(title: "Service near your", items: Array(services.suffix(3))),
        ServiceSection(title: "Available this week", items: Array(services.suffix(3)))
    ]
    
    static let searchRecentQueries: [String] = [
        "nails",
        "photos",
        "haircuts",
        "plumbing",
        "programming",
        "tutoring",
        "makeup",
        "videography",
        "editing",
        "moving",
        "painting"
    ]
    
    static let searchRecentServices: [Service] = {
        var services = SampleData.services
        services.append(
            Service(
                id: UUID(),
                category: "photo",
                providerPFP: "lauren",
                providerName: "Alex Kim",
                serviceImage: "GradPhoto",
                description: "Event videography and edits",
                price: "From $120/hour",
                rating: 4.7
            )
        )
        return services
    }()
    
    static let searchResults: [Service] = [
        Service(
            id: UUID(),
            category: "photo",
            providerPFP: "lauren",
            providerName: "Jennifer Gu",
            serviceImage: "GradPhoto",
            description: "class of '26 photoshoots!",
            price: "From $67/hour",
            rating: 4.1
        ),
        Service(
            id: UUID(),
            category: "photo",
            providerPFP: "lauren",
            providerName: "Jennifer Gu",
            serviceImage: "GradPhoto",
            description: "class of '26 photoshoots!",
            price: "From $67/hour",
            rating: 4.1
        )
    ]
}
