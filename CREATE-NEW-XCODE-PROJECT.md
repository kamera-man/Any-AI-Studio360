# Creating a New Xcode Project with Studio 360° Code

This guide shows you how to create a **brand new** Xcode project and import the Studio 360° source code, rather than using the existing `.xcodeproj` file.

## ⚠️ Important: Locate Your Repository First

Before following this guide, you need to know where you cloned the repository on your computer.

**The source files are located at**: `[YOUR_REPO_PATH]/Any-AI-Studio360/Studio360/Studio360/`

**Common locations:**
- `~/Any-AI-Studio360/Studio360/Studio360/` (cloned to home directory)
- `~/GitHub/Any-AI-Studio360/Studio360/Studio360/` (cloned to GitHub folder)
- `~/Documents/Any-AI-Studio360/Studio360/Studio360/` (cloned to Documents)

**To find it, open Terminal and run:**
```bash
# Find the repository location
find ~ -name "Any-AI-Studio360" -type d 2>/dev/null | head -1

# Or navigate to where you cloned it
cd ~/GitHub/Any-AI-Studio360  # (adjust path as needed)
ls -la Studio360/Studio360/   # You should see: App, Models, ViewModels, Views, Services, Resources
```

Throughout this guide, replace `[YOUR_REPO_PATH]` with your actual path.

## Why Create a New Project?

You might want to create a new Xcode project if you:
- Want to customize project settings from scratch
- Need to integrate with an existing workspace
- Want to use a different bundle identifier or organization
- Prefer to set up your own build configurations

## Step-by-Step Guide

### Step 1: Create a New iOS App Project

1. **Open Xcode**

2. **Create New Project**
   - Select `File > New > Project...` (or press `⇧⌘N`)
   - Or click "Create New Project" on the welcome screen

3. **Choose Template**
   - Select **iOS** tab at the top
   - Choose **App** template
   - Click **Next**

4. **Configure Your Project**
   - **Product Name**: `Studio360` (or your preferred name)
   - **Team**: Select your Apple Developer team
   - **Organization Identifier**: `com.yourcompany` (or your preference)
   - **Bundle Identifier**: Will be auto-generated (e.g., `com.yourcompany.Studio360`)
   - **Interface**: Select **SwiftUI**
   - **Language**: Select **Swift**
   - **Storage**: Leave unchecked (we'll use UserDefaults)
   - **Include Tests**: ✅ Check this box
   - Click **Next**

5. **Choose Location**
   - Navigate to where you want to create the project
   - Click **Create**

### Step 2: Prepare Project Structure

1. **Delete Default Files**
   
   In the Xcode navigator, select and delete these default files:
   - `ContentView.swift` (we'll replace it)
   - `Studio360App.swift` (we'll replace it)
   - `Assets.xcassets` (we'll replace it)
   
   When prompted, select **Move to Trash**

2. **Create Folder Structure**
   
   Right-click on the `Studio360` group and create these groups (folders):
   - `App`
   - `Models`
   - `ViewModels`
   - `Views`
     - `Home` (sub-group)
     - `Albums` (sub-group)
     - `Photos` (sub-group)
     - `Settings` (sub-group)
   - `Services`
   - `Resources`

### Step 3: Locate the Source Files in Your Repository

**Important**: First, find where you cloned the repository. The source files are located in the `Studio360/Studio360/` subdirectory within your cloned repository.

**Example locations:**
- If you cloned to your home directory: `~/Any-AI-Studio360/Studio360/Studio360/`
- If you cloned to GitHub folder: `~/GitHub/Any-AI-Studio360/Studio360/Studio360/`
- If you cloned elsewhere: `[YOUR_PATH]/Any-AI-Studio360/Studio360/Studio360/`

**To find your repository location:**
```bash
# If you're not sure where you cloned it, search for it:
find ~ -name "Any-AI-Studio360" -type d 2>/dev/null | head -1
```

Once you know your repository location, the source files are in:
```
[YOUR_REPO_PATH]/Any-AI-Studio360/
└── Studio360/
    └── Studio360/  ← Source files are here
        ├── App/
        ├── Models/
        ├── ViewModels/
        ├── Views/
        ├── Services/
        └── Resources/
```

### Step 4: Import Source Files

Now we'll copy the source files from your repository location.

**Note**: In the instructions below, replace `[YOUR_REPO_PATH]` with your actual repository path (e.g., `~/GitHub/Any-AI-Studio360` or wherever you cloned it).

#### A. Copy App Files

1. **Import Studio360App.swift**:
   - Right-click on `App` group in Xcode
   - Select `Add Files to "Studio360"...`
   - Navigate to `[YOUR_REPO_PATH]/Any-AI-Studio360/Studio360/Studio360/App/`
   - Select `Studio360App.swift`
   - Make sure **"Copy items if needed"** is checked
   - Make sure target is selected
   - Click **Add**

2. **Import ContentView.swift**:
   - Repeat the process for `ContentView.swift` from the same folder

#### B. Copy Model Files

From `[YOUR_REPO_PATH]/Any-AI-Studio360/Studio360/Studio360/Models/`:

1. Add to `Models` group:
   - `Photo.swift`
   - `Album.swift`
   - `FamilyMember.swift`

#### C. Copy ViewModel Files

From `[YOUR_REPO_PATH]/Any-AI-Studio360/Studio360/Studio360/ViewModels/`:

1. Add to `ViewModels` group:
   - `PhotoLibraryViewModel.swift`
   - `AlbumViewModel.swift`

#### D. Copy Service Files

From `[YOUR_REPO_PATH]/Any-AI-Studio360/Studio360/Studio360/Services/`:

1. Add to `Services` group:
   - `PhotoService.swift`
   - `StorageService.swift`

#### E. Copy View Files

From `[YOUR_REPO_PATH]/Any-AI-Studio360/Studio360/Studio360/Views/`:

1. Add to `Views/Home` group:
   - `HomeView.swift`

2. Add to `Views/Albums` group:
   - `AlbumListView.swift`
   - `AlbumDetailView.swift`

3. Add to `Views/Photos` group:
   - `PhotoGridView.swift`
   - `PhotoDetailView.swift`

4. Add to `Views/Settings` group:
   - `SettingsView.swift`

#### F. Copy Resources

1. **Assets**:
   - Copy the entire `Assets.xcassets` folder from `[YOUR_REPO_PATH]/Any-AI-Studio360/Studio360/Studio360/Resources/`
   - Drag it into the `Resources` group in Xcode
   - Make sure "Copy items if needed" is checked

2. **Info.plist**:
   - The new project has Info.plist values in the target settings
   - We need to add privacy permissions

### Step 4: Configure Info.plist Permissions

1. **Select Your Project** in the navigator

2. **Select the Studio360 Target**

3. **Go to the Info Tab**

4. **Add Privacy Permissions**:
   
   Click the **+** button next to any key and add these:

   - **Key**: `Privacy - Photo Library Usage Description`
     - **Value**: `Studio 360° needs access to your photo library to display and manage your family photos.`
   
   - **Key**: `Privacy - Photo Library Additions Usage Description`
     - **Value**: `Studio 360° needs access to save photos to your library.`
   
   - **Key**: `Privacy - Camera Usage Description`
     - **Value**: `Studio 360° needs access to your camera to capture new family moments.`

### Step 5: Configure Build Settings

1. **Deployment Target**:
   - In your target's **General** tab
   - Set **Minimum Deployments** to **iOS 15.0**

2. **App Display Name**:
   - In the **General** tab
   - Set **Display Name** to **Studio 360°**

### Step 6: Import Test Files (Optional)

If you want to include the test suite:

1. **Navigate to Test Target**:
   - Find `Studio360Tests` group in navigator

2. **Delete Default Test File**:
   - Delete the default test file

3. **Add Test Files**:
   
   From `[YOUR_REPO_PATH]/Any-AI-Studio360/Studio360Tests/`:
   - `PhotoTests.swift`
   - `AlbumTests.swift`
   - `FamilyMemberTests.swift`
   - `PhotoLibraryViewModelTests.swift`
   - `AlbumViewModelTests.swift`
   
   Make sure to:
   - Check "Copy items if needed"
   - Select the **Studio360Tests** target (not the main target)

### Step 7: Verify and Build

1. **Check File Structure**:
   
   Your project should look like:
   ```
   Studio360/
   ├── App/
   │   ├── Studio360App.swift
   │   └── ContentView.swift
   ├── Models/
   │   ├── Photo.swift
   │   ├── Album.swift
   │   └── FamilyMember.swift
   ├── ViewModels/
   │   ├── PhotoLibraryViewModel.swift
   │   └── AlbumViewModel.swift
   ├── Views/
   │   ├── Home/
   │   │   └── HomeView.swift
   │   ├── Albums/
   │   │   ├── AlbumListView.swift
   │   │   └── AlbumDetailView.swift
   │   ├── Photos/
   │   │   ├── PhotoGridView.swift
   │   │   └── PhotoDetailView.swift
   │   └── Settings/
   │       └── SettingsView.swift
   ├── Services/
   │   ├── PhotoService.swift
   │   └── StorageService.swift
   └── Resources/
       └── Assets.xcassets/
   ```

2. **Build the Project**:
   - Press `⌘B` to build
   - Fix any errors (there shouldn't be any if files were imported correctly)

3. **Run the App**:
   - Select a simulator
   - Press `⌘R` to run
   - The app should launch with sample data

## Alternative: Quick Import Method

If you want to import all files at once:

1. **Create the folder structure** as described in Step 2

2. **Select all source files** from the repository:
   - In Finder, navigate to `[YOUR_REPO_PATH]/Any-AI-Studio360/Studio360/Studio360/`
   - Select all folders (App, Models, ViewModels, Views, Services, Resources)

3. **Drag into Xcode**:
   - Drag them into the project navigator
   - When prompted:
     - ✅ Check "Copy items if needed"
     - ✅ Select "Create groups"
     - ✅ Add to target: Studio360
     - Click **Finish**

4. **Reorganize** if needed:
   - Xcode might not preserve the exact structure
   - Drag files into the correct groups

## Troubleshooting

### Build Errors

**"Cannot find 'XXX' in scope"**
- Make sure all Swift files are added to the target
- Check: Right-click file > Show File Inspector > Target Membership

**"Duplicate symbol"**
- You might have imported files twice
- Check for duplicate files in different groups
- Remove duplicates

**"Missing module 'SwiftUI'"**
- Make sure deployment target is iOS 15.0+
- Check Xcode version (needs 15.0+)

### Files Not Showing

**Files are gray/not building**:
- Select the file
- Open File Inspector (⌥⌘1)
- Check the **Target Membership** box for your app target

### Privacy Permission Issues

**App crashes when accessing photos**:
- Double-check Info.plist privacy keys are added
- Make sure keys are spelled exactly as shown above

## Alternative Approach: Use Existing Project

If you prefer to use the existing Xcode project structure:

See **XCODE-SETUP.md** for instructions on opening the pre-configured project directly.

## Customization After Import

### Change Bundle Identifier

1. Select project in navigator
2. Select target
3. Go to **General** tab
4. Update **Bundle Identifier**

### Change Team

1. Select project in navigator
2. Select target
3. Go to **Signing & Capabilities**
4. Select your **Team**

### Change Organization Name

1. For each Swift file:
2. Update the header comment
3. Or use Find & Replace in Xcode

## Next Steps

Once your project is set up:

1. **Run the app** (⌘R) to verify everything works
2. **Run tests** (⌘U) to ensure test suite is working
3. **Customize** the code for your needs
4. **Add your own features**

See the other documentation files for more information:
- **README.md**: Project overview and features
- **ARCHITECTURE.md**: Technical architecture details
- **TESTING.md**: Testing strategy and guide
- **XCODE-SETUP.md**: Instructions for using the existing project

## Summary

You now have a brand new Xcode project with all the Studio 360° source code imported! The process involved:

✅ Creating a new iOS app project in Xcode
✅ Setting up the proper folder structure
✅ Importing all source files from the repository
✅ Configuring Info.plist privacy permissions
✅ Setting deployment target to iOS 15.0
✅ Importing test files (optional)
✅ Building and running the app

The app will launch with sample data pre-loaded and all features working!
