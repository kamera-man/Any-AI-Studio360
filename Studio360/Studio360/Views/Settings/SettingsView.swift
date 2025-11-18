//
//  SettingsView.swift
//  Studio360
//
//  Created on Nov 18, 2025
//

import SwiftUI

struct SettingsView: View {
    @State private var familyMembers: [FamilyMember] = []
    @State private var notificationsEnabled = true
    @State private var autoBackup = false
    @State private var highQualityUpload = true
    
    var body: some View {
        NavigationView {
            List {
                // Family Section
                Section {
                    ForEach(familyMembers) { member in
                        FamilyMemberRow(member: member)
                    }
                    
                    Button(action: {}) {
                        Label("Invite Family Member", systemImage: "person.badge.plus")
                    }
                } header: {
                    Text("Family Members")
                } footer: {
                    Text("\(familyMembers.count) family members")
                }
                
                // Preferences Section
                Section("Preferences") {
                    Toggle(isOn: $notificationsEnabled) {
                        Label("Notifications", systemImage: "bell")
                    }
                    
                    Toggle(isOn: $autoBackup) {
                        Label("Auto Backup", systemImage: "arrow.clockwise.icloud")
                    }
                    
                    Toggle(isOn: $highQualityUpload) {
                        Label("High Quality Upload", systemImage: "photo.badge.arrow.down")
                    }
                }
                
                // Storage Section
                Section("Storage") {
                    HStack {
                        Label("Used Storage", systemImage: "internaldrive")
                        Spacer()
                        Text("2.4 GB")
                            .foregroundColor(.secondary)
                    }
                    
                    Button(action: {}) {
                        Label("Manage Storage", systemImage: "gear")
                    }
                }
                
                // Privacy & Security
                Section("Privacy & Security") {
                    NavigationLink(destination: Text("Privacy Settings")) {
                        Label("Privacy Settings", systemImage: "hand.raised")
                    }
                    
                    NavigationLink(destination: Text("Security")) {
                        Label("Security", systemImage: "lock.shield")
                    }
                }
                
                // About Section
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    NavigationLink(destination: Text("Terms & Conditions")) {
                        Text("Terms & Conditions")
                    }
                    
                    NavigationLink(destination: Text("Privacy Policy")) {
                        Text("Privacy Policy")
                    }
                    
                    Link("Visit Website", destination: URL(string: "https://studio360.app")!)
                }
                
                // Support Section
                Section("Support") {
                    Button(action: {}) {
                        Label("Help & FAQ", systemImage: "questionmark.circle")
                    }
                    
                    Button(action: {}) {
                        Label("Contact Support", systemImage: "envelope")
                    }
                    
                    Button(action: {}) {
                        Label("Report a Bug", systemImage: "ladybug")
                    }
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                loadFamilyMembers()
            }
        }
    }
    
    private func loadFamilyMembers() {
        Task {
            do {
                familyMembers = try await StorageService.shared.fetchFamilyMembers()
            } catch {
                print("Failed to load family members: \(error)")
            }
        }
    }
}

// MARK: - Supporting Views

struct FamilyMemberRow: View {
    let member: FamilyMember
    
    var body: some View {
        HStack(spacing: 12) {
            // Avatar
            Circle()
                .fill(Color(hex: member.avatarColor) ?? .blue)
                .frame(width: 40, height: 40)
                .overlay(
                    Text(member.initials)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 2) {
                Text(member.name)
                    .font(.body)
                    .fontWeight(.medium)
                
                Text(member.relationship)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Permission badge
            Text(member.permissions.rawValue)
                .font(.caption2)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(permissionColor(for: member.permissions).opacity(0.2))
                .foregroundColor(permissionColor(for: member.permissions))
                .cornerRadius(6)
        }
    }
    
    private func permissionColor(for permission: MemberPermissions) -> Color {
        switch permission {
        case .admin: return .red
        case .standard: return .blue
        case .viewOnly: return .gray
        }
    }
}

// MARK: - Color Extension

extension Color {
    init?(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return nil
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
#endif
