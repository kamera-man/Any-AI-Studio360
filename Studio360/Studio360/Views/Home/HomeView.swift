//
//  HomeView.swift
//  Studio360
//
//  Created on Nov 18, 2025
//

import SwiftUI

struct HomeView: View {
    @StateObject private var photoViewModel = PhotoLibraryViewModel()
    @State private var familyMembers: [FamilyMember] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Welcome Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome to Studio 360°")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Capture and share your family's precious moments")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    // Stats Cards
                    HStack(spacing: 15) {
                        StatCard(
                            title: "Photos",
                            count: photoViewModel.photos.count,
                            icon: "photo.fill",
                            color: .blue
                        )
                        
                        StatCard(
                            title: "360° Photos",
                            count: photoViewModel.photos.filter { $0.is360 }.count,
                            icon: "panorama.fill",
                            color: .green
                        )
                        
                        StatCard(
                            title: "Family",
                            count: familyMembers.count,
                            icon: "person.3.fill",
                            color: .orange
                        )
                    }
                    .padding(.horizontal)
                    
                    // Recent Photos Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Recent Photos")
                                .font(.headline)
                            
                            Spacer()
                            
                            NavigationLink(destination: PhotoGridView()) {
                                Text("See All")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                        
                        if photoViewModel.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .padding()
                        } else if let errorMessage = photoViewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(photoViewModel.photos.prefix(5)) { photo in
                                        NavigationLink(destination: PhotoDetailView(photo: photo)) {
                                            RecentPhotoCard(photo: photo)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    // Quick Actions
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Quick Actions")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        VStack(spacing: 10) {
                            QuickActionButton(
                                title: "Create New Album",
                                icon: "folder.badge.plus",
                                color: .blue
                            )
                            
                            QuickActionButton(
                                title: "View 360° Gallery",
                                icon: "panorama",
                                color: .green
                            )
                            
                            QuickActionButton(
                                title: "Family Settings",
                                icon: "person.3.sequence",
                                color: .orange
                            )
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Home")
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

struct StatCard: View {
    let title: String
    let count: Int
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text("\(count)")
                .font(.title2)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
    }
}

struct RecentPhotoCard: View {
    let photo: Photo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Placeholder image
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(
                    colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 150, height: 150)
                .overlay(
                    Image(systemName: photo.is360 ? "panorama.fill" : "photo.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                )
            
            Text(photo.title)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(1)
            
            Text(photo.formattedDate)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(width: 150)
    }
}

struct QuickActionButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        Button(action: {
            // Action placeholder
        }) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(color)
                    .frame(width: 30)
                
                Text(title)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(10)
        }
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif
