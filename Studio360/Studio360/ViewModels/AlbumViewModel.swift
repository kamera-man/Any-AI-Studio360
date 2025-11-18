//
//  AlbumViewModel.swift
//  Studio360
//
//  Created on Nov 18, 2025
//

import Foundation
import SwiftUI

@MainActor
class AlbumViewModel: ObservableObject {
    @Published var albums: [Album] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchQuery = ""
    
    private let storageService: StorageService
    
    init(storageService: StorageService = StorageService.shared) {
        self.storageService = storageService
        loadAlbums()
    }
    
    /// Load all albums
    func loadAlbums() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                albums = try await storageService.fetchAlbums()
                isLoading = false
            } catch {
                errorMessage = "Failed to load albums: \(error.localizedDescription)"
                isLoading = false
            }
        }
    }
    
    /// Filtered albums based on search query
    var filteredAlbums: [Album] {
        if searchQuery.isEmpty {
            return albums.sorted { $0.modifiedDate > $1.modifiedDate }
        }
        
        return albums.filter { album in
            album.name.localizedCaseInsensitiveContains(searchQuery) ||
            album.description.localizedCaseInsensitiveContains(searchQuery)
        }.sorted { $0.modifiedDate > $1.modifiedDate }
    }
    
    /// Create a new album
    func createAlbum(name: String, description: String = "") {
        let newAlbum = Album(
            name: name,
            description: description
        )
        albums.append(newAlbum)
        storageService.saveAlbum(newAlbum)
    }
    
    /// Delete an album
    func deleteAlbum(_ album: Album) {
        albums.removeAll { $0.id == album.id }
        storageService.deleteAlbum(album)
    }
    
    /// Update an album
    func updateAlbum(_ album: Album) {
        if let index = albums.firstIndex(where: { $0.id == album.id }) {
            var updatedAlbum = album
            updatedAlbum.modifiedDate = Date()
            albums[index] = updatedAlbum
            storageService.saveAlbum(updatedAlbum)
        }
    }
    
    /// Add a photo to an album
    func addPhoto(_ photoID: UUID, toAlbum albumID: UUID) {
        if let index = albums.firstIndex(where: { $0.id == albumID }) {
            var album = albums[index]
            if !album.photoIDs.contains(photoID) {
                album.photoIDs.append(photoID)
                album.modifiedDate = Date()
                albums[index] = album
                storageService.saveAlbum(album)
            }
        }
    }
    
    /// Remove a photo from an album
    func removePhoto(_ photoID: UUID, fromAlbum albumID: UUID) {
        if let index = albums.firstIndex(where: { $0.id == albumID }) {
            var album = albums[index]
            album.photoIDs.removeAll { $0 == photoID }
            album.modifiedDate = Date()
            albums[index] = album
            storageService.saveAlbum(album)
        }
    }
    
    /// Refresh albums
    func refresh() {
        loadAlbums()
    }
}
