# Studio 360° - Xcode Setup Instructions

## Overview

This guide shows you how to **open the existing Xcode project** that's included in this repository.

> **Want to create a new Xcode project instead?** See **CREATE-NEW-XCODE-PROJECT.md** for instructions on creating a fresh project and importing the source code.

## Quick Start Guide

Follow these steps to open and run the Studio 360° iOS app in Xcode using the existing project.

### Prerequisites

- **macOS**: Ventura (13.0) or later
- **Xcode**: Version 15.0 or later
- **iOS Device/Simulator**: iOS 15.0 or later

### Step 1: Clone the Repository

If you haven't already cloned the repository:

```bash
git clone https://github.com/kamera-man/Any-AI-Studio360.git
cd Any-AI-Studio360
```

Or if you're already in the repository:

```bash
cd /path/to/Any-AI-Studio360
```

### Step 2: Open the Project in Xcode

You have two options:

#### Option A: Using Finder
1. Navigate to the `Studio360` folder
2. Double-click on `Studio360.xcodeproj`
3. Xcode will launch automatically

#### Option B: Using Terminal
```bash
cd Studio360
open Studio360.xcodeproj
```

Or use the `xed` command:
```bash
xed Studio360
```

### Step 3: Configure Xcode Project

Once Xcode opens:

1. **Select a Team** (for code signing):
   - Click on the project name "Studio360" in the navigator
   - Select the "Studio360" target
   - Go to "Signing & Capabilities" tab
   - Under "Team", select your Apple Developer account
   - If you don't have one, select "Add Account..." to sign in with your Apple ID

2. **Verify Bundle Identifier** (optional):
   - The default is `com.studio360.app`
   - You can change it to match your organization

3. **Select a Destination**:
   - In the toolbar, click the device/simulator selector
   - Choose an iOS Simulator (e.g., "iPhone 15 Pro")
   - Or connect a physical device and select it

### Step 4: Build the Project

1. **Clean Build Folder** (optional, but recommended):
   ```
   Product > Clean Build Folder (⇧⌘K)
   ```

2. **Build the Project**:
   ```
   Product > Build (⌘B)
   ```
   
   Wait for the build to complete. You should see "Build Succeeded" in the status bar.

### Step 5: Run the App

1. **Run on Simulator/Device**:
   ```
   Product > Run (⌘R)
   ```

2. The app will launch, and you'll see:
   - The home screen with welcome message
   - Sample photos and albums pre-loaded
   - Family member profiles
   - All features ready to explore

### Step 6: Explore the App

The app has 4 main tabs:

1. **Home** 🏠
   - Dashboard with statistics
   - Recent photos preview
   - Quick actions

2. **Albums** 📁
   - View all albums
   - Create new albums
   - Browse album contents

3. **Photos** 📷
   - Grid view of all photos
   - Search and filter options
   - 360° photo indicators

4. **Settings** ⚙️
   - Family member management
   - App preferences
   - Privacy settings

## Project Structure in Xcode

When you open the project, you'll see this structure:

```
Studio360
├── Studio360
│   ├── App
│   │   ├── Studio360App.swift          # App entry point
│   │   └── ContentView.swift           # Root view
│   ├── Models
│   │   ├── Photo.swift                 # Photo data model
│   │   ├── Album.swift                 # Album data model
│   │   └── FamilyMember.swift          # Family member model
│   ├── ViewModels
│   │   ├── PhotoLibraryViewModel.swift
│   │   └── AlbumViewModel.swift
│   ├── Views
│   │   ├── Home
│   │   │   └── HomeView.swift
│   │   ├── Albums
│   │   │   ├── AlbumListView.swift
│   │   │   └── AlbumDetailView.swift
│   │   ├── Photos
│   │   │   ├── PhotoGridView.swift
│   │   │   └── PhotoDetailView.swift
│   │   └── Settings
│   │       └── SettingsView.swift
│   ├── Services
│   │   ├── PhotoService.swift
│   │   └── StorageService.swift
│   └── Resources
│       ├── Assets.xcassets
│       └── Info.plist
└── Studio360Tests
    ├── PhotoTests.swift
    ├── AlbumTests.swift
    ├── FamilyMemberTests.swift
    ├── PhotoLibraryViewModelTests.swift
    └── AlbumViewModelTests.swift
```

## Running Tests

### Run All Tests
```
Product > Test (⌘U)
```

### Run Specific Test File
1. Open the test file in Xcode
2. Click the diamond icon next to the test class or method
3. Or use ⌘U while the test file is open

### View Test Results
- Press ⌘9 to open the Report Navigator
- Click on the latest test run
- Expand to see individual test results

### Test Coverage
1. Edit Scheme (⌘<)
2. Select "Test" in the left sidebar
3. Check "Gather coverage for" and select targets
4. Run tests (⌘U)
5. View coverage in Report Navigator (⌘9)

## Understanding the Sample Data

The app comes pre-loaded with sample data for testing:

### Sample Photos (5 items)
Located in `Photo.swift` under `Photo.samplePhotos`:
- "Family Vacation 2025" (360°)
- "Birthday Party"
- "Nature Walk" (360°)
- "Dinner Time"
- "Sunset View" (360°)

### Sample Albums (4 items)
Located in `Album.swift` under `Album.sampleAlbums`:
- "Family Vacation 2025"
- "Birthday Celebrations"
- "360° Memories" (Smart Album)
- "Favorites"

### Sample Family Members (5 items)
Located in `FamilyMember.swift` under `FamilyMember.sampleMembers`:
- Mom (Admin)
- Dad (Admin)
- Emma (Standard)
- Noah (Standard)
- Grandma (View Only)

### Where Data is Stored

The sample data is automatically loaded on first launch and stored in:
- **UserDefaults** for MVP implementation
- Keys: `studio360.photos`, `studio360.albums`, `studio360.familyMembers`

### Resetting Data

To reset to sample data:
1. Delete the app from simulator/device
2. Reinstall and run again

Or programmatically:
```swift
// Clear all data
PhotoService.shared.clearAllPhotos()
StorageService.shared.clearAllData()

// Restart the app to reload sample data
```

## Customizing the Sample Data

### Adding More Sample Photos

Edit `Studio360/Studio360/Models/Photo.swift`:

```swift
extension Photo {
    static let samplePhotos: [Photo] = [
        Photo(
            title: "Your Custom Photo",
            captureDate: Date(),
            location: "Your Location",
            is360: false,
            tags: ["custom", "new"]
        ),
        // ... add more photos
    ]
}
```

### Adding More Sample Albums

Edit `Studio360/Studio360/Models/Album.swift`:

```swift
extension Album {
    static let sampleAlbums: [Album] = [
        Album(
            name: "Your Custom Album",
            description: "Description here",
            isSmartAlbum: false
        ),
        // ... add more albums
    ]
}
```

### Adding More Family Members

Edit `Studio360/Studio360/Models/FamilyMember.swift`:

```swift
extension FamilyMember {
    static let sampleMembers: [FamilyMember] = [
        FamilyMember(
            name: "New Member",
            relationship: "Sibling",
            avatarColor: "#FF5733",
            permissions: .standard
        ),
        // ... add more members
    ]
}
```

## Troubleshooting

### Build Errors

**"No such module 'SwiftUI'"**
- Make sure you're using Xcode 15.0 or later
- Check deployment target is iOS 15.0+

**"Code signing error"**
- Go to project settings > Signing & Capabilities
- Select your team or add your Apple ID

**"Simulator not available"**
- Go to Xcode > Settings > Platforms
- Download iOS 15.0+ simulator

### Runtime Issues

**"App crashes on launch"**
- Check the console for error messages
- Verify all files are included in the target

**"No data showing"**
- The sample data loads automatically
- Try deleting and reinstalling the app

**"Photos not displaying"**
- This is expected - we use placeholder gradients
- Real photo support can be added by integrating with PhotoKit

### Performance

**"App is slow"**
- The app uses lazy loading for optimal performance
- Simulators are slower than real devices
- Try running on a physical device

## Next Steps

### Integrating with Real Photo Library

To connect with the device photo library:

1. The permissions are already in `Info.plist`:
   - `NSPhotoLibraryUsageDescription`
   - `NSCameraUsageDescription`

2. Import PhotoKit framework:
```swift
import PhotoKit
```

3. Request authorization:
```swift
PHPhotoLibrary.requestAuthorization { status in
    // Handle authorization
}
```

4. Fetch photos:
```swift
let fetchOptions = PHFetchOptions()
let assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
```

### Adding Real Images

The current implementation uses placeholder gradients. To add real images:

1. Import images to Assets.xcassets
2. Use `Image("imageName")` in SwiftUI
3. Or integrate with PhotoKit to load device photos

### Cloud Sync

To add cloud synchronization:

1. Enable CloudKit capability
2. Update services to use CloudKit
3. Handle sync conflicts
4. Add offline support

### Advanced Features

See the roadmap in `README.md` for:
- Advanced 360° viewer with gesture controls
- Video support
- AI-powered organization
- Collaborative editing
- Custom themes

## Additional Resources

- **README.md**: Overview and features
- **ARCHITECTURE.md**: Technical architecture details
- **TESTING.md**: Testing strategy and guide
- **CONTRIBUTING.md**: How to contribute
- **API Documentation**: Inline comments in source files

## Getting Help

If you encounter any issues:

1. Check the **Troubleshooting** section above
2. Review the console logs in Xcode
3. Read the documentation files
4. Open an issue on GitHub

## Summary

You now have a fully functional iOS app running in Xcode! The app includes:
- ✅ Complete UI with 4 tabs
- ✅ Sample data pre-loaded
- ✅ All features working
- ✅ Ready for customization
- ✅ Test suite included

**Happy coding!** 🚀
