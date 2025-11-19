//
//  FamilyMemberTests.swift
//  Studio360Tests
//
//  Created on Nov 18, 2025
//

import XCTest
@testable import Studio360

final class FamilyMemberTests: XCTestCase {
    
    func testFamilyMemberInitialization() {
        // Given
        let name = "John Doe"
        let relationship = "Parent"
        
        // When
        let member = FamilyMember(name: name, relationship: relationship)
        
        // Then
        XCTAssertEqual(member.name, name)
        XCTAssertEqual(member.relationship, relationship)
        XCTAssertNotNil(member.id)
        XCTAssertEqual(member.permissions, .standard)
    }
    
    func testFamilyMemberInitials() {
        // Given
        let member1 = FamilyMember(name: "John Doe", relationship: "Parent")
        let member2 = FamilyMember(name: "Jane", relationship: "Parent")
        
        // When & Then
        XCTAssertEqual(member1.initials, "JD")
        XCTAssertEqual(member2.initials, "J")
    }
    
    func testMemberPermissionsCanAddPhotos() {
        // Given & When & Then
        XCTAssertTrue(MemberPermissions.admin.canAddPhotos)
        XCTAssertTrue(MemberPermissions.standard.canAddPhotos)
        XCTAssertFalse(MemberPermissions.viewOnly.canAddPhotos)
    }
    
    func testMemberPermissionsCanDeletePhotos() {
        // Given & When & Then
        XCTAssertTrue(MemberPermissions.admin.canDeletePhotos)
        XCTAssertFalse(MemberPermissions.standard.canDeletePhotos)
        XCTAssertFalse(MemberPermissions.viewOnly.canDeletePhotos)
    }
    
    func testMemberPermissionsCanManageAlbums() {
        // Given & When & Then
        XCTAssertTrue(MemberPermissions.admin.canManageAlbums)
        XCTAssertTrue(MemberPermissions.standard.canManageAlbums)
        XCTAssertFalse(MemberPermissions.viewOnly.canManageAlbums)
    }
    
    func testMemberPermissionsCanInviteMembers() {
        // Given & When & Then
        XCTAssertTrue(MemberPermissions.admin.canInviteMembers)
        XCTAssertFalse(MemberPermissions.standard.canInviteMembers)
        XCTAssertFalse(MemberPermissions.viewOnly.canInviteMembers)
    }
    
    func testFamilyMemberSampleData() {
        // When
        let sampleMembers = FamilyMember.sampleMembers
        
        // Then
        XCTAssertFalse(sampleMembers.isEmpty)
        XCTAssertEqual(sampleMembers.count, 5)
        XCTAssertTrue(sampleMembers.contains(where: { $0.permissions == .admin }))
        XCTAssertTrue(sampleMembers.contains(where: { $0.permissions == .viewOnly }))
    }
    
    func testFamilyMemberCodable() throws {
        // Given
        let member = FamilyMember(
            name: "Test Member",
            relationship: "Parent",
            email: "test@example.com",
            permissions: .admin
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(member)
        
        let decoder = JSONDecoder()
        let decodedMember = try decoder.decode(FamilyMember.self, from: data)
        
        // Then
        XCTAssertEqual(member.id, decodedMember.id)
        XCTAssertEqual(member.name, decodedMember.name)
        XCTAssertEqual(member.relationship, decodedMember.relationship)
        XCTAssertEqual(member.email, decodedMember.email)
        XCTAssertEqual(member.permissions, decodedMember.permissions)
    }
}
