//
//  AlbumDetailView.swift
//  Studio360
//
//  Created on Nov 18, 2025
//

import SwiftUI

struct AlbumDetailView: View {
    let album: Album
    @StateObject private var photoViewModel = PhotoLibraryViewModel()
    @State private var showingEditSheet = false
    
    var albumPhotos: [Photo] {
        photoViewModel.photos.filter { photo in
            album.photoIDs.contains(photo.id)
        }
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 100), spacing: 10)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Album Header
                VStack(alignment: .leading, spacing: 8) {
                    if !album.description.isEmpty {
                        Text(album.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Label("\(album.photoCount) photos", systemImage: "photo")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        if album.isSmartAlbum {
                            Label("Smart Album", systemImage: "sparkles")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Photos Grid
                if albumPhotos.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.system(size: 50))
                            .foregroundColor(.secondary)
                        
                        Text("No Photos Yet")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("Add photos to this album from your library")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 60)
                } else {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(albumPhotos) { photo in
                            NavigationLink(destination: PhotoDetailView(photo: photo)) {
                                AlbumPhotoThumbnail(photo: photo)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle(album.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: { showingEditSheet = true }) {
                        Label("Edit Album", systemImage: "pencil")
                    }
                    
                    Button(action: {}) {
                        Label("Share Album", systemImage: "square.and.arrow.up")
                    }
                    
                    Button(role: .destructive, action: {}) {
                        Label("Delete Album", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
    }
}

// MARK: - Supporting Views

struct AlbumPhotoThumbnail: View {
    let photo: Photo
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(LinearGradient(
                colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                VStack {
                    Spacer()
                    if photo.is360 {
                        HStack {
                            Spacer()
                            Image(systemName: "panorama.fill")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(6)
                                .background(.ultraThinMaterial)
                                .cornerRadius(6)
                                .padding(6)
                        }
                    }
                }
            )
    }
}

#if DEBUG
struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlbumDetailView(album: Album.sampleAlbums[0])
        }
    }
}
#endif
