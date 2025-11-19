//
//  StorageService.swift
//  Studio360
//
//  Created on Nov 18, 2025
//

import Foundation

/// Service for managing albums and general storage
class StorageService {
    static let shared = StorageService()
    
    private let userDefaults = UserDefaults.standard
    private let albumsKey = "studio360.albums"
    private let familyMembersKey = "studio360.familyMembers"
    
    private init() {}
    
    // MARK: - Album Management
    
    /// Fetch all albums
    func fetchAlbums() async throws -> [Album] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        // Try to load from UserDefaults, otherwise return sample data
        if let data = userDefaults.data(forKey: albumsKey),
           let albums = try? JSONDecoder().decode([Album].self, from: data) {
            return albums
        }
        
        // Return sample data on first launch
        let sampleAlbums = Album.sampleAlbums
        try? saveAlbums(sampleAlbums)
        return sampleAlbums
    }
    
    /// Save a single album
    func saveAlbum(_ album: Album) {
        Task {
            var albums = (try? await fetchAlbums()) ?? []
            if let index = albums.firstIndex(where: { $0.id == album.id }) {
                albums[index] = album
            } else {
                albums.append(album)
            }
            try? saveAlbums(albums)
        }
    }
    
    /// Delete an album
    func deleteAlbum(_ album: Album) {
        Task {
            var albums = (try? await fetchAlbums()) ?? []
            albums.removeAll { $0.id == album.id }
            try? saveAlbums(albums)
        }
    }
    
    /// Save all albums to storage
    private func saveAlbums(_ albums: [Album]) throws {
        let data = try JSONEncoder().encode(albums)
        userDefaults.set(data, forKey: albumsKey)
    }
    
    // MARK: - Family Member Management
    
    /// Fetch all family members
    func fetchFamilyMembers() async throws -> [FamilyMember] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 300_000_000) // 0.3 seconds
        
        // Try to load from UserDefaults, otherwise return sample data
        if let data = userDefaults.data(forKey: familyMembersKey),
           let members = try? JSONDecoder().decode([FamilyMember].self, from: data) {
            return members
        }
        
        // Return sample data on first launch
        let sampleMembers = FamilyMember.sampleMembers
        try? saveFamilyMembers(sampleMembers)
        return sampleMembers
    }
    
    /// Save a single family member
    func saveFamilyMember(_ member: FamilyMember) {
        Task {
            var members = (try? await fetchFamilyMembers()) ?? []
            if let index = members.firstIndex(where: { $0.id == member.id }) {
                members[index] = member
            } else {
                members.append(member)
            }
            try? saveFamilyMembers(members)
        }
    }
    
    /// Save all family members to storage
    private func saveFamilyMembers(_ members: [FamilyMember]) throws {
        let data = try JSONEncoder().encode(members)
        userDefaults.set(data, forKey: familyMembersKey)
    }
    
    // MARK: - Clear Data (for testing)
    
    /// Clear all stored data
    func clearAllData() {
        userDefaults.removeObject(forKey: albumsKey)
        userDefaults.removeObject(forKey: familyMembersKey)
    }
}
