//
//  FamilyMember.swift
//  Studio360
//
//  Created on Nov 18, 2025
//

import Foundation
import SwiftUI

/// Represents a family member in the Studio 360° app
struct FamilyMember: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var relationship: String
    var avatarColor: String // Stored as hex color string
    var email: String?
    var dateJoined: Date
    var permissions: MemberPermissions
    
    init(
        id: UUID = UUID(),
        name: String,
        relationship: String,
        avatarColor: String = "#007AFF",
        email: String? = nil,
        dateJoined: Date = Date(),
        permissions: MemberPermissions = .standard
    ) {
        self.id = id
        self.name = name
        self.relationship = relationship
        self.avatarColor = avatarColor
        self.email = email
        self.dateJoined = dateJoined
        self.permissions = permissions
    }
    
    /// Returns initials from the name
    var initials: String {
        let components = name.split(separator: " ")
        let initials = components.prefix(2).compactMap { $0.first }
        return String(initials).uppercased()
    }
}

/// Permission levels for family members
enum MemberPermissions: String, Codable {
    case admin = "Admin"
    case standard = "Standard"
    case viewOnly = "View Only"
    
    var canAddPhotos: Bool {
        self != .viewOnly
    }
    
    var canDeletePhotos: Bool {
        self == .admin
    }
    
    var canManageAlbums: Bool {
        self != .viewOnly
    }
    
    var canInviteMembers: Bool {
        self == .admin
    }
}

// MARK: - Sample Data
extension FamilyMember {
    static let sampleMembers: [FamilyMember] = [
        FamilyMember(
            name: "Mom",
            relationship: "Parent",
            avatarColor: "#FF6B6B",
            permissions: .admin
        ),
        FamilyMember(
            name: "Dad",
            relationship: "Parent",
            avatarColor: "#4ECDC4",
            permissions: .admin
        ),
        FamilyMember(
            name: "Emma",
            relationship: "Child",
            avatarColor: "#95E1D3",
            permissions: .standard
        ),
        FamilyMember(
            name: "Noah",
            relationship: "Child",
            avatarColor: "#F38181",
            permissions: .standard
        ),
        FamilyMember(
            name: "Grandma",
            relationship: "Grandparent",
            avatarColor: "#AA96DA",
            permissions: .viewOnly
        )
    ]
}
