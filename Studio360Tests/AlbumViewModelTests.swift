//
//  AlbumViewModelTests.swift
//  Studio360Tests
//
//  Created on Nov 18, 2025
//

import XCTest
@testable import Studio360

@MainActor
final class AlbumViewModelTests: XCTestCase {
    
    var viewModel: AlbumViewModel!
    
    override func setUp() async throws {
        await super.setUp()
        viewModel = AlbumViewModel()
        // Wait a moment for initial load
        try? await Task.sleep(nanoseconds: 600_000_000)
    }
    
    override func tearDown() async throws {
        viewModel = nil
        await super.tearDown()
    }
    
    func testInitialLoad() async throws {
        // Then
        XCTAssertFalse(viewModel.albums.isEmpty, "Albums should be loaded on initialization")
        XCTAssertFalse(viewModel.isLoading, "Loading should be complete")
        XCTAssertNil(viewModel.errorMessage, "No error should occur")
    }
    
    func testSearchFilter() async throws {
        // Given
        viewModel.searchQuery = "vacation"
        
        // When
        let filteredAlbums = viewModel.filteredAlbums
        
        // Then
        XCTAssertTrue(filteredAlbums.allSatisfy { album in
            album.name.localizedCaseInsensitiveContains("vacation") ||
            album.description.localizedCaseInsensitiveContains("vacation")
        })
    }
    
    func testCreateAlbum() async throws {
        // Given
        let initialCount = viewModel.albums.count
        let albumName = "Test Album"
        let albumDescription = "Test Description"
        
        // When
        viewModel.createAlbum(name: albumName, description: albumDescription)
        
        // Then
        XCTAssertEqual(viewModel.albums.count, initialCount + 1)
        XCTAssertTrue(viewModel.albums.contains(where: { 
            $0.name == albumName && $0.description == albumDescription 
        }))
    }
    
    func testDeleteAlbum() async throws {
        // Given
        let albumToDelete = viewModel.albums.first!
        let initialCount = viewModel.albums.count
        
        // When
        viewModel.deleteAlbum(albumToDelete)
        
        // Then
        XCTAssertEqual(viewModel.albums.count, initialCount - 1)
        XCTAssertFalse(viewModel.albums.contains(where: { $0.id == albumToDelete.id }))
    }
    
    func testUpdateAlbum() async throws {
        // Given
        var album = viewModel.albums.first!
        let newName = "Updated Album Name"
        album.name = newName
        
        // When
        viewModel.updateAlbum(album)
        
        // Then
        let updatedAlbum = viewModel.albums.first(where: { $0.id == album.id })
        XCTAssertEqual(updatedAlbum?.name, newName)
    }
    
    func testAddPhotoToAlbum() async throws {
        // Given
        let album = viewModel.albums.first!
        let photoID = UUID()
        let initialPhotoCount = album.photoCount
        
        // When
        viewModel.addPhoto(photoID, toAlbum: album.id)
        
        // Then
        let updatedAlbum = viewModel.albums.first(where: { $0.id == album.id })
        XCTAssertEqual(updatedAlbum?.photoCount, initialPhotoCount + 1)
        XCTAssertTrue(updatedAlbum?.photoIDs.contains(photoID) ?? false)
    }
    
    func testRemovePhotoFromAlbum() async throws {
        // Given
        let photoID = UUID()
        let album = viewModel.albums.first!
        viewModel.addPhoto(photoID, toAlbum: album.id)
        
        // Wait for the add operation
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        let photoCountAfterAdd = viewModel.albums.first(where: { $0.id == album.id })?.photoCount ?? 0
        
        // When
        viewModel.removePhoto(photoID, fromAlbum: album.id)
        
        // Then
        try? await Task.sleep(nanoseconds: 100_000_000)
        let updatedAlbum = viewModel.albums.first(where: { $0.id == album.id })
        XCTAssertFalse(updatedAlbum?.photoIDs.contains(photoID) ?? true)
    }
    
    func testFilteredAlbumsSorting() async throws {
        // Given
        viewModel.searchQuery = ""
        
        // When
        let filteredAlbums = viewModel.filteredAlbums
        
        // Then - should be sorted by modified date (most recent first)
        for i in 0..<(filteredAlbums.count - 1) {
            XCTAssertGreaterThanOrEqual(
                filteredAlbums[i].modifiedDate,
                filteredAlbums[i + 1].modifiedDate
            )
        }
    }
    
    func testRefresh() async throws {
        // Given
        let initialAlbums = viewModel.albums
        
        // When
        viewModel.refresh()
        try? await Task.sleep(nanoseconds: 600_000_000)
        
        // Then
        XCTAssertFalse(viewModel.isLoading, "Loading should complete")
        XCTAssertFalse(viewModel.albums.isEmpty, "Albums should be reloaded")
    }
}
