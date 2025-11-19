//
//  PhotoLibraryViewModel.swift
//  Studio360
//
//  Created on Nov 18, 2025
//

import Foundation
import SwiftUI

@MainActor
class PhotoLibraryViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchQuery = ""
    @Published var selectedFilter: PhotoFilter = .all
    
    private let photoService: PhotoService
    
    init(photoService: PhotoService = PhotoService.shared) {
        self.photoService = photoService
        loadPhotos()
    }
    
    /// Load all photos from the service
    func loadPhotos() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                photos = try await photoService.fetchPhotos()
                isLoading = false
            } catch {
                errorMessage = "Failed to load photos: \(error.localizedDescription)"
                isLoading = false
            }
        }
    }
    
    /// Filtered photos based on search and filter
    var filteredPhotos: [Photo] {
        var result = photos
        
        // Apply search filter
        if !searchQuery.isEmpty {
            result = result.filter { photo in
                photo.title.localizedCaseInsensitiveContains(searchQuery) ||
                photo.tags.contains(where: { $0.localizedCaseInsensitiveContains(searchQuery) })
            }
        }
        
        // Apply category filter
        switch selectedFilter {
        case .all:
            break
        case .is360:
            result = result.filter { $0.is360 }
        case .recent:
            result = result.filter { Calendar.current.isDateInToday($0.captureDate) || Calendar.current.isDateInYesterday($0.captureDate) }
        case .favorites:
            // Future implementation for favorites
            break
        }
        
        return result.sorted { $0.captureDate > $1.captureDate }
    }
    
    /// Add a new photo
    func addPhoto(_ photo: Photo) {
        photos.append(photo)
        photoService.savePhoto(photo)
    }
    
    /// Delete a photo
    func deletePhoto(_ photo: Photo) {
        photos.removeAll { $0.id == photo.id }
        photoService.deletePhoto(photo)
    }
    
    /// Refresh photos
    func refresh() {
        loadPhotos()
    }
}

/// Filter options for photos
enum PhotoFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case is360 = "360° Photos"
    case recent = "Recent"
    case favorites = "Favorites"
    
    var id: String { rawValue }
}
