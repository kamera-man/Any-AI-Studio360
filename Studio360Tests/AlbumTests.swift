//
//  AlbumTests.swift
//  Studio360Tests
//
//  Created on Nov 18, 2025
//

import XCTest
@testable import Studio360

final class AlbumTests: XCTestCase {
    
    func testAlbumInitialization() {
        // Given
        let name = "Test Album"
        let description = "Test Description"
        
        // When
        let album = Album(name: name, description: description)
        
        // Then
        XCTAssertEqual(album.name, name)
        XCTAssertEqual(album.description, description)
        XCTAssertNotNil(album.id)
        XCTAssertNotNil(album.createdDate)
        XCTAssertEqual(album.photoCount, 0)
    }
    
    func testAlbumPhotoCount() {
        // Given
        let photoIDs = [UUID(), UUID(), UUID()]
        
        // When
        let album = Album(name: "Test", photoIDs: photoIDs)
        
        // Then
        XCTAssertEqual(album.photoCount, 3)
    }
    
    func testAlbumFormattedDate() {
        // Given
        let album = Album(name: "Test Album")
        
        // When
        let formattedDate = album.formattedCreationDate
        
        // Then
        XCTAssertFalse(formattedDate.isEmpty)
    }
    
    func testAlbumSampleData() {
        // When
        let sampleAlbums = Album.sampleAlbums
        
        // Then
        XCTAssertFalse(sampleAlbums.isEmpty)
        XCTAssertEqual(sampleAlbums.count, 4)
        XCTAssertTrue(sampleAlbums.contains(where: { $0.isSmartAlbum }))
    }
    
    func testAlbumCodable() throws {
        // Given
        let album = Album(
            name: "Test Album",
            description: "Test Description",
            photoIDs: [UUID(), UUID()],
            isSmartAlbum: true
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(album)
        
        let decoder = JSONDecoder()
        let decodedAlbum = try decoder.decode(Album.self, from: data)
        
        // Then
        XCTAssertEqual(album.id, decodedAlbum.id)
        XCTAssertEqual(album.name, decodedAlbum.name)
        XCTAssertEqual(album.description, decodedAlbum.description)
        XCTAssertEqual(album.photoCount, decodedAlbum.photoCount)
        XCTAssertEqual(album.isSmartAlbum, decodedAlbum.isSmartAlbum)
    }
}
