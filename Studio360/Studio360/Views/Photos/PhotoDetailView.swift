//
//  PhotoDetailView.swift
//  Studio360
//
//  Created on Nov 18, 2025
//

import SwiftUI

struct PhotoDetailView: View {
    let photo: Photo
    @Environment(\.dismiss) private var dismiss
    @State private var showingShareSheet = false
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Photo Display
                RoundedRectangle(cornerRadius: 12)
                    .fill(LinearGradient(
                        colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .aspectRatio(4/3, contentMode: .fit)
                    .overlay(
                        VStack {
                            Image(systemName: photo.is360 ? "panorama.fill" : "photo.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                            
                            if photo.is360 {
                                Text("360° Photo")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.top, 8)
                            }
                        }
                    )
                    .padding(.horizontal)
                
                // Photo Information
                VStack(alignment: .leading, spacing: 16) {
                    // Title
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Title")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text(photo.title)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    
                    Divider()
                    
                    // Date and Location
                    HStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 4) {
                            Label("Date", systemImage: "calendar")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Text(photo.formattedDate)
                                .font(.subheadline)
                        }
                        
                        if let location = photo.location {
                            VStack(alignment: .leading, spacing: 4) {
                                Label("Location", systemImage: "location")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Text(location)
                                    .font(.subheadline)
                            }
                        }
                    }
                    
                    // Tags
                    if !photo.tags.isEmpty {
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Tags")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            FlowLayout(spacing: 8) {
                                ForEach(photo.tags, id: \.self) { tag in
                                    TagView(tag: tag)
                                }
                            }
                        }
                    }
                    
                    // 360° Info
                    if photo.is360 {
                        Divider()
                        
                        HStack(spacing: 12) {
                            Image(systemName: "panorama.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("360° Photo")
                                    .font(.headline)
                                
                                Text("Swipe to explore the full panoramic view")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Spacer(minLength: 100)
            }
            .padding(.vertical)
        }
        .navigationTitle("Photo Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: { showingShareSheet = true }) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    
                    Button(action: {}) {
                        Label("Add to Album", systemImage: "folder.badge.plus")
                    }
                    
                    Button(action: {}) {
                        Label("Edit", systemImage: "pencil")
                    }
                    
                    Divider()
                    
                    Button(role: .destructive, action: { showingDeleteAlert = true }) {
                        Label("Delete", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .alert("Delete Photo", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete this photo? This action cannot be undone.")
        }
    }
}

// MARK: - Supporting Views

struct TagView: View {
    let tag: String
    
    var body: some View {
        Text("#\(tag)")
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.blue.opacity(0.2))
            .foregroundColor(.blue)
            .cornerRadius(8)
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.replacingUnspecifiedDimensions().width, subviews: subviews, spacing: spacing)
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        for (index, subview) in subviews.enumerated() {
            let position = result.positions[index]
            subview.place(at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y), proposal: .unspecified)
        }
    }
    
    struct FlowResult {
        var size: CGSize
        var positions: [CGPoint]
        
        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var positions: [CGPoint] = []
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var lineHeight: CGFloat = 0
            
            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                
                if currentX + size.width > maxWidth && currentX > 0 {
                    currentX = 0
                    currentY += lineHeight + spacing
                    lineHeight = 0
                }
                
                positions.append(CGPoint(x: currentX, y: currentY))
                lineHeight = max(lineHeight, size.height)
                currentX += size.width + spacing
            }
            
            self.size = CGSize(width: maxWidth, height: currentY + lineHeight)
            self.positions = positions
        }
    }
}

#if DEBUG
struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PhotoDetailView(photo: Photo.samplePhotos[0])
        }
    }
}
#endif
