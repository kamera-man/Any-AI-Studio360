# Studio 360° iOS App

![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-Yes-green.svg)
![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)

A modern, family-centered photo and video management iOS application that celebrates life's moments together with innovative 360° viewing capabilities.

## 🌟 Features

### Core Features (MVP)
- ✅ **Photo Library Management**: Browse and organize your family photos
- ✅ **Album Organization**: Create and manage albums with ease
- ✅ **Family Sharing**: Collaborate with family members on shared albums
- ✅ **360° Photo Support**: Immersive viewing experience for panoramic photos
- ✅ **Smart Organization**: Intelligent filtering and searching
- ✅ **Settings & Configuration**: Comprehensive app preferences

### Design Philosophy
- **Family-First Design**: Every feature enhances family connection
- **Privacy & Security**: Family data is protected and secure
- **Intuitive Interface**: Easy for all ages and skill levels
- **Quality Over Quantity**: Focus on stability and user experience
- **Crash-Free Operation**: Zero tolerance for crashes

## 📱 Requirements

- iOS 15.0 or later
- Xcode 15.0 or later
- Swift 5.9 or later

## 🚀 Getting Started

### Choose Your Setup Method

**Option 1: Use Existing Project** (Recommended)
- Quick and easy - just open and run
- See **XCODE-SETUP.md** for detailed instructions

**Option 2: Create New Project**
- Start fresh with your own Xcode project
- Import source files manually
- See **CREATE-NEW-XCODE-PROJECT.md** for step-by-step guide

### Quick Start (Option 1)

1. **Clone the repository**
   ```bash
   git clone https://github.com/kamera-man/Any-AI-Studio360.git
   cd Any-AI-Studio360
   ```

2. **Open in Xcode**
   ```bash
   open Studio360/Studio360.xcodeproj
   ```

3. **Build and Run**
   - Select your target device or simulator
   - Press `⌘R` or click the Run button
   - The app will compile and launch with sample data

### Project Structure

```
Studio360/
├── App/
│   ├── Studio360App.swift        # Main app entry point
│   └── ContentView.swift         # Root view with tab navigation
├── Models/
│   ├── Photo.swift               # Photo data model
│   ├── Album.swift               # Album data model
│   └── FamilyMember.swift        # Family member model
├── ViewModels/
│   ├── PhotoLibraryViewModel.swift
│   └── AlbumViewModel.swift
├── Views/
│   ├── Home/
│   │   └── HomeView.swift        # Home dashboard
│   ├── Albums/
│   │   ├── AlbumListView.swift
│   │   └── AlbumDetailView.swift
│   ├── Photos/
│   │   ├── PhotoGridView.swift
│   │   └── PhotoDetailView.swift
│   └── Settings/
│       └── SettingsView.swift
├── Services/
│   ├── PhotoService.swift        # Photo management service
│   └── StorageService.swift      # Data persistence service
└── Resources/
    └── Assets.xcassets
```

## 🏗️ Architecture

The app follows the **MVVM (Model-View-ViewModel)** architecture pattern:

- **Models**: Define data structures (Photo, Album, FamilyMember)
- **Views**: SwiftUI views for UI components
- **ViewModels**: Business logic and state management
- **Services**: Data management and persistence

## 🧪 Testing

### Running Tests

```bash
# Run all tests
⌘U in Xcode

# Or via command line (if xcodebuild is available)
xcodebuild test -scheme Studio360 -destination 'platform=iOS Simulator,name=iPhone 15'
```

### Test Coverage

- Unit tests for ViewModels
- Service layer tests
- UI tests for critical flows
- Target: 70%+ code coverage

## 📋 Development Guidelines

### Code Quality
- Follow Swift style guidelines
- Use SwiftLint for consistency
- No force unwrapping without guards
- Comprehensive error handling
- Proper documentation

### Git Workflow
- Main branch: production-ready code
- Feature branches: new features
- Conventional commits
- Semantic versioning (MAJOR.MINOR.PATCH)

### Commit Message Format
```
type(scope): subject

body

footer
```

**Types**: feat, fix, docs, style, refactor, test, chore

## 🔒 Security & Privacy

- Local-first data storage using UserDefaults
- Proper privacy permissions (Photos, Camera)
- No hardcoded credentials
- Follows Apple's privacy guidelines
- User-controlled sharing

## ♿ Accessibility

- VoiceOver support
- Dynamic Type support
- High contrast mode
- Minimum touch target: 44x44 pts

## 🌍 Localization

- English (US) as base language
- Ready for additional languages
- Locale-aware date/time formatting

## 📦 Dependencies

Currently, the app uses only system frameworks:
- SwiftUI for UI
- Foundation for core functionality
- Combine for reactive programming

No external dependencies required for MVP!

## 🚀 Deployment

### TestFlight Beta

1. Archive the app in Xcode
2. Upload to App Store Connect
3. Submit for TestFlight review
4. Share with beta testers

### App Store Release

1. Prepare App Store metadata
2. Create screenshots and preview video
3. Submit for App Store review
4. Follow App Store Review Guidelines

## 📖 Documentation

- [AI Starter Message](AI-Starter-Message.md)
- [AI Delegation Specification](Studio360-AI-Delegation-Specification.md)
- [AI Branch Creation Instructions](AI-Branch-Creation-Instructions.md)

## 🤝 Contributing

This project welcomes contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Write/update tests
5. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Team

Created with ❤️ by the Studio 360° team

## 🙏 Acknowledgments

- Built with SwiftUI
- Inspired by family moments
- Designed for everyone

## 📞 Support

- Email: support@studio360.app
- Issues: [GitHub Issues](https://github.com/kamera-man/Any-AI-Studio360/issues)
- Documentation: [Wiki](https://github.com/kamera-man/Any-AI-Studio360/wiki)

## 🗺️ Roadmap

### Version 1.1
- [ ] Cloud sync capability
- [ ] Advanced 360° viewer
- [ ] Video support
- [ ] Advanced search filters

### Version 1.2
- [ ] AI-powered photo organization
- [ ] Collaborative editing
- [ ] Custom themes
- [ ] iPad optimization

### Version 2.0
- [ ] AR features
- [ ] Live photos support
- [ ] Advanced privacy features
- [ ] Offline mode enhancements

---

**Built with Swift and SwiftUI** | **Made for Families** | **Privacy First**
