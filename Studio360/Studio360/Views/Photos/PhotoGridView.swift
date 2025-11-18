//
//  PhotoGridView.swift
//  Studio360
//
//  Created on Nov 18, 2025
//

import SwiftUI

struct PhotoGridView: View {
    @StateObject private var viewModel = PhotoLibraryViewModel()
    @State private var selectedPhoto: Photo?
    
    let columns = [
        GridItem(.adaptive(minimum: 100), spacing: 10)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading photos...")
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
                } else if viewModel.filteredPhotos.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.system(size: 60))
                            .foregroundColor(.secondary)
                        
                        Text("No Photos Yet")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Start capturing your family's precious moments")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.filteredPhotos) { photo in
                                NavigationLink(destination: PhotoDetailView(photo: photo)) {
                                    PhotoThumbnail(photo: photo)
                                }
                            }
                        }
                        .padding()
                    }
                    .refreshable {
                        viewModel.refresh()
                    }
                }
            }
            .navigationTitle("Photos")
            .searchable(text: $viewModel.searchQuery, prompt: "Search photos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $viewModel.selectedFilter) {
                            ForEach(PhotoFilter.allCases) { filter in
                                Label(filter.rawValue, systemImage: iconForFilter(filter))
                                    .tag(filter)
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
    }
    
    private func iconForFilter(_ filter: PhotoFilter) -> String {
        switch filter {
        case .all: return "photo.stack"
        case .is360: return "panorama"
        case .recent: return "clock"
        case .favorites: return "heart.fill"
        }
    }
}

// MARK: - Supporting Views

struct PhotoThumbnail: View {
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
                    HStack {
                        if photo.is360 {
                            Image(systemName: "panorama.fill")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(6)
                                .background(.ultraThinMaterial)
                                .cornerRadius(6)
                        }
                        Spacer()
                    }
                    .padding(6)
                }
            )
    }
}

#if DEBUG
struct PhotoGridView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGridView()
    }
}
#endif
