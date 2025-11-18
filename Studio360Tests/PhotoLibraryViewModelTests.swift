//
//  PhotoLibraryViewModelTests.swift
//  Studio360Tests
//
//  Created on Nov 18, 2025
//

import XCTest
@testable import Studio360

@MainActor
final class PhotoLibraryViewModelTests: XCTestCase {
    
    var viewModel: PhotoLibraryViewModel!
    
    override func setUp() async throws {
        await super.setUp()
        viewModel = PhotoLibraryViewModel()
        // Wait a moment for initial load
        try? await Task.sleep(nanoseconds: 600_000_000)
    }
    
    override func tearDown() async throws {
        viewModel = nil
        await super.tearDown()
    }
    
    func testInitialLoad() async throws {
        // Then
        XCTAssertFalse(viewModel.photos.isEmpty, "Photos should be loaded on initialization")
        XCTAssertFalse(viewModel.isLoading, "Loading should be complete")
        XCTAssertNil(viewModel.errorMessage, "No error should occur")
    }
    
    func testSearchFilter() async throws {
        // Given
        viewModel.searchQuery = "vacation"
        
        // When
        let filteredPhotos = viewModel.filteredPhotos
        
        // Then
        XCTAssertTrue(filteredPhotos.allSatisfy { photo in
            photo.title.localizedCaseInsensitiveContains("vacation") ||
            photo.tags.contains(where: { $0.localizedCaseInsensitiveContains("vacation") })
        })
    }
    
    func testPhotoFilterAll() async throws {
        // Given
        viewModel.selectedFilter = .all
        
        // When
        let filteredPhotos = viewModel.filteredPhotos
        
        // Then
        XCTAssertEqual(filteredPhotos.count, viewModel.photos.count)
    }
    
    func testPhotoFilter360() async throws {
        // Given
        viewModel.selectedFilter = .is360
        
        // When
        let filteredPhotos = viewModel.filteredPhotos
        
        // Then
        XCTAssertTrue(filteredPhotos.allSatisfy { $0.is360 })
    }
    
    func testAddPhoto() async throws {
        // Given
        let initialCount = viewModel.photos.count
        let newPhoto = Photo(title: "New Test Photo")
        
        // When
        viewModel.addPhoto(newPhoto)
        
        // Then
        XCTAssertEqual(viewModel.photos.count, initialCount + 1)
        XCTAssertTrue(viewModel.photos.contains(where: { $0.id == newPhoto.id }))
    }
    
    func testDeletePhoto() async throws {
        // Given
        let photoToDelete = viewModel.photos.first!
        let initialCount = viewModel.photos.count
        
        // When
        viewModel.deletePhoto(photoToDelete)
        
        // Then
        XCTAssertEqual(viewModel.photos.count, initialCount - 1)
        XCTAssertFalse(viewModel.photos.contains(where: { $0.id == photoToDelete.id }))
    }
    
    func testRefresh() async throws {
        // Given
        let initialPhotos = viewModel.photos
        
        // When
        viewModel.refresh()
        try? await Task.sleep(nanoseconds: 600_000_000)
        
        // Then
        XCTAssertFalse(viewModel.isLoading, "Loading should complete")
        XCTAssertFalse(viewModel.photos.isEmpty, "Photos should be reloaded")
    }
}
