//
//  PhotoTests.swift
//  Studio360Tests
//
//  Created on Nov 18, 2025
//

import XCTest
@testable import Studio360

final class PhotoTests: XCTestCase {
    
    func testPhotoInitialization() {
        // Given
        let title = "Test Photo"
        let location = "Test Location"
        let is360 = true
        
        // When
        let photo = Photo(
            title: title,
            location: location,
            is360: is360
        )
        
        // Then
        XCTAssertEqual(photo.title, title)
        XCTAssertEqual(photo.location, location)
        XCTAssertTrue(photo.is360)
        XCTAssertNotNil(photo.id)
        XCTAssertNotNil(photo.captureDate)
    }
    
    func testPhotoFormattedDate() {
        // Given
        let photo = Photo(title: "Test Photo")
        
        // When
        let formattedDate = photo.formattedDate
        
        // Then
        XCTAssertFalse(formattedDate.isEmpty)
        XCTAssertTrue(formattedDate.contains(","))
    }
    
    func testPhotoSampleData() {
        // When
        let samplePhotos = Photo.samplePhotos
        
        // Then
        XCTAssertFalse(samplePhotos.isEmpty)
        XCTAssertEqual(samplePhotos.count, 5)
        XCTAssertTrue(samplePhotos.contains(where: { $0.is360 }))
    }
    
    func testPhotoCodable() throws {
        // Given
        let photo = Photo(
            title: "Test Photo",
            location: "Test Location",
            is360: true,
            tags: ["test", "photo"]
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(photo)
        
        let decoder = JSONDecoder()
        let decodedPhoto = try decoder.decode(Photo.self, from: data)
        
        // Then
        XCTAssertEqual(photo.id, decodedPhoto.id)
        XCTAssertEqual(photo.title, decodedPhoto.title)
        XCTAssertEqual(photo.is360, decodedPhoto.is360)
        XCTAssertEqual(photo.tags, decodedPhoto.tags)
    }
}
