//
//  PhotoService.swift
//  Studio360
//
//  Created on Nov 18, 2025
//

import Foundation
import SwiftUI

/// Service for managing photos
class PhotoService {
    static let shared = PhotoService()
    
    private let userDefaults = UserDefaults.standard
    private let photosKey = "studio360.photos"
    
    private init() {}
    
    /// Fetch all photos
    func fetchPhotos() async throws -> [Photo] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        // Try to load from UserDefaults, otherwise return sample data
        if let data = userDefaults.data(forKey: photosKey),
           let photos = try? JSONDecoder().decode([Photo].self, from: data) {
            return photos
        }
        
        // Return sample data on first launch
        let samplePhotos = Photo.samplePhotos
        try? savePhotos(samplePhotos)
        return samplePhotos
    }
    
    /// Save a single photo
    func savePhoto(_ photo: Photo) {
        Task {
            var photos = (try? await fetchPhotos()) ?? []
            if let index = photos.firstIndex(where: { $0.id == photo.id }) {
                photos[index] = photo
            } else {
                photos.append(photo)
            }
            try? savePhotos(photos)
        }
    }
    
    /// Delete a photo
    func deletePhoto(_ photo: Photo) {
        Task {
            var photos = (try? await fetchPhotos()) ?? []
            photos.removeAll { $0.id == photo.id }
            try? savePhotos(photos)
        }
    }
    
    /// Save all photos to storage
    private func savePhotos(_ photos: [Photo]) throws {
        let data = try JSONEncoder().encode(photos)
        userDefaults.set(data, forKey: photosKey)
    }
    
    /// Clear all photos (for testing)
    func clearAllPhotos() {
        userDefaults.removeObject(forKey: photosKey)
    }
}
