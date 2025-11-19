//
//  Album.swift
//  Studio360
//
//  Created on Nov 18, 2025
//

import Foundation

/// Represents an album containing photos
struct Album: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var description: String
    let createdDate: Date
    var modifiedDate: Date
    var photoIDs: [UUID]
    var coverPhotoID: UUID?
    var sharedWithFamilyMembers: [UUID]
    var createdBy: UUID?
    var isSmartAlbum: Bool
    
    init(
        id: UUID = UUID(),
        name: String,
        description: String = "",
        createdDate: Date = Date(),
        modifiedDate: Date = Date(),
        photoIDs: [UUID] = [],
        coverPhotoID: UUID? = nil,
        sharedWithFamilyMembers: [UUID] = [],
        createdBy: UUID? = nil,
        isSmartAlbum: Bool = false
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.createdDate = createdDate
        self.modifiedDate = modifiedDate
        self.photoIDs = photoIDs
        self.coverPhotoID = coverPhotoID
        self.sharedWithFamilyMembers = sharedWithFamilyMembers
        self.createdBy = createdBy
        self.isSmartAlbum = isSmartAlbum
    }
    
    /// Returns the number of photos in the album
    var photoCount: Int {
        photoIDs.count
    }
    
    /// Returns a formatted date string for creation
    var formattedCreationDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: createdDate)
    }
}

// MARK: - Sample Data
extension Album {
    static let sampleAlbums: [Album] = [
        Album(
            name: "Family Vacation 2025",
            description: "Our amazing summer vacation at the beach",
            photoIDs: [],
            isSmartAlbum: false
        ),
        Album(
            name: "Birthday Celebrations",
            description: "All birthday moments captured",
            photoIDs: [],
            isSmartAlbum: false
        ),
        Album(
            name: "360° Memories",
            description: "Special immersive photos",
            photoIDs: [],
            isSmartAlbum: true
        ),
        Album(
            name: "Favorites",
            description: "Our most cherished moments",
            photoIDs: [],
            isSmartAlbum: false
        )
    ]
}
