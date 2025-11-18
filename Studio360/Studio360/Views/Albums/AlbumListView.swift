//
//  AlbumListView.swift
//  Studio360
//
//  Created on Nov 18, 2025
//

import SwiftUI

struct AlbumListView: View {
    @StateObject private var viewModel = AlbumViewModel()
    @State private var showingCreateSheet = false
    @State private var newAlbumName = ""
    @State private var newAlbumDescription = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading albums...")
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                        
                        Text(errorMessage)
                            .multilineTextAlignment(.center)
                        
                        Button("Retry") {
                            viewModel.refresh()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else if viewModel.filteredAlbums.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "folder")
                            .font(.system(size: 60))
                            .foregroundColor(.secondary)
                        
                        Text("No Albums Yet")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Create your first album to organize your family photos")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                        
                        Button(action: { showingCreateSheet = true }) {
                            Label("Create Album", systemImage: "plus.circle.fill")
                                .font(.headline)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    List {
                        ForEach(viewModel.filteredAlbums) { album in
                            NavigationLink(destination: AlbumDetailView(album: album)) {
                                AlbumRow(album: album)
                            }
                        }
                        .onDelete(perform: deleteAlbums)
                    }
                    .searchable(text: $viewModel.searchQuery, prompt: "Search albums")
                    .refreshable {
                        viewModel.refresh()
                    }
                }
            }
            .navigationTitle("Albums")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingCreateSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingCreateSheet) {
                CreateAlbumSheet(
                    albumName: $newAlbumName,
                    albumDescription: $newAlbumDescription,
                    onCreate: {
                        viewModel.createAlbum(name: newAlbumName, description: newAlbumDescription)
                        newAlbumName = ""
                        newAlbumDescription = ""
                        showingCreateSheet = false
                    },
                    onCancel: {
                        newAlbumName = ""
                        newAlbumDescription = ""
                        showingCreateSheet = false
                    }
                )
            }
        }
    }
    
    private func deleteAlbums(at offsets: IndexSet) {
        for index in offsets {
            let album = viewModel.filteredAlbums[index]
            viewModel.deleteAlbum(album)
        }
    }
}

// MARK: - Supporting Views

struct AlbumRow: View {
    let album: Album
    
    var body: some View {
        HStack(spacing: 15) {
            // Album cover placeholder
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(
                    colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 80, height: 80)
                .overlay(
                    VStack {
                        Image(systemName: album.isSmartAlbum ? "sparkles" : "folder.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        if album.photoCount > 0 {
                            Text("\(album.photoCount)")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(album.name)
                    .font(.headline)
                
                if !album.description.isEmpty {
                    Text(album.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                HStack {
                    Text("\(album.photoCount) photos")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if album.isSmartAlbum {
                        Text("• Smart Album")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct CreateAlbumSheet: View {
    @Binding var albumName: String
    @Binding var albumDescription: String
    let onCreate: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Album Details")) {
                    TextField("Album Name", text: $albumName)
                    
                    TextField("Description (optional)", text: $albumDescription, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Create Album")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: onCancel)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create", action: onCreate)
                        .disabled(albumName.isEmpty)
                }
            }
        }
    }
}

#if DEBUG
struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}
#endif
