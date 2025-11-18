//
//  Photo.swift
//  Studio360
//
//  Created on Nov 18, 2025
//

import Foundation
import SwiftUI

/// Represents a photo in the Studio 360° app
struct Photo: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let captureDate: Date
    let location: String?
    let is360: Bool
    var tags: [String]
    var albumIDs: [UUID]
    var addedBy: UUID? // Family member who added this photo
    
    init(
        id: UUID = UUID(),
        title: String,
        captureDate: Date = Date(),
        location: String? = nil,
        is360: Bool = false,
        tags: [String] = [],
        albumIDs: [UUID] = [],
        addedBy: UUID? = nil
    ) {
        self.id = id
        self.title = title
        self.captureDate = captureDate
        self.location = location
        self.is360 = is360
        self.tags = tags
        self.albumIDs = albumIDs
        self.addedBy = addedBy
    }
    
    /// Returns a formatted date string
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: captureDate)
    }
}

// MARK: - Sample Data
extension Photo {
    static let samplePhotos: [Photo] = [
        Photo(
            title: "Family Vacation 2025",
            captureDate: Date().addingTimeInterval(-86400 * 30),
            location: "Beach Resort",
            is360: true,
            tags: ["vacation", "family", "summer"]
        ),
        Photo(
            title: "Birthday Party",
            captureDate: Date().addingTimeInterval(-86400 * 15),
            location: "Home",
            tags: ["birthday", "celebration"]
        ),
        Photo(
            title: "Nature Walk",
            captureDate: Date().addingTimeInterval(-86400 * 7),
            location: "Central Park",
            is360: true,
            tags: ["nature", "outdoor"]
        ),
        Photo(
            title: "Dinner Time",
            captureDate: Date().addingTimeInterval(-86400 * 2),
            location: "Home",
            tags: ["family", "meal"]
        ),
        Photo(
            title: "Sunset View",
            captureDate: Date().addingTimeInterval(-86400),
            location: "Hilltop",
            is360: true,
            tags: ["nature", "sunset"]
        )
    ]
}
