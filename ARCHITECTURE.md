# Studio 360° Architecture

## Overview

Studio 360° follows the **MVVM (Model-View-ViewModel)** architecture pattern with SwiftUI, providing a clean separation of concerns and making the codebase maintainable and testable.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────┐
│                         Views                            │
│  (SwiftUI Components - Presentation Layer)              │
│                                                          │
│  HomeView, AlbumListView, PhotoGridView, etc.           │
└──────────────────┬───────────────────────────────────────┘
                   │ Binding, State, Actions
                   │
┌──────────────────▼───────────────────────────────────────┐
│                     ViewModels                           │
│  (@MainActor ObservableObject - Business Logic)         │
│                                                          │
│  PhotoLibraryViewModel, AlbumViewModel                  │
└──────────────────┬───────────────────────────────────────┘
                   │ Async Calls
                   │
┌──────────────────▼───────────────────────────────────────┐
│                     Services                             │
│  (Data Management & Business Rules)                      │
│                                                          │
│  PhotoService, StorageService                           │
└──────────────────┬───────────────────────────────────────┘
                   │ CRUD Operations
                   │
┌──────────────────▼───────────────────────────────────────┐
│                      Models                              │
│  (Data Structures & Domain Logic)                        │
│                                                          │
│  Photo, Album, FamilyMember                             │
└──────────────────────────────────────────────────────────┘
```

## Layers

### 1. View Layer (SwiftUI)

**Responsibility**: Presentation and user interaction

**Components**:
- `HomeView`: Dashboard with statistics and quick actions
- `AlbumListView`: Album browsing interface
- `AlbumDetailView`: Individual album view
- `PhotoGridView`: Photo library grid
- `PhotoDetailView`: Individual photo details
- `SettingsView`: App configuration

**Key Characteristics**:
- Declarative UI with SwiftUI
- Reactive to ViewModel changes
- No business logic
- Lightweight and focused
- Reusable components

### 2. ViewModel Layer

**Responsibility**: Business logic and state management

**Components**:
- `PhotoLibraryViewModel`: Manages photo library state
- `AlbumViewModel`: Manages album state

**Key Characteristics**:
- Marked with `@MainActor` for UI thread safety
- Conforms to `ObservableObject`
- Uses `@Published` properties for reactive updates
- Handles user actions
- Manages loading and error states
- Async operations with proper error handling

### 3. Service Layer

**Responsibility**: Data access and persistence

**Components**:
- `PhotoService`: Photo CRUD operations
- `StorageService`: Album and family member storage

**Key Characteristics**:
- Singleton pattern for app-wide access
- Async/await for data operations
- UserDefaults for persistence (MVP)
- Simulated network delays for realistic UX
- Error handling and propagation

### 4. Model Layer

**Responsibility**: Data structures and domain logic

**Components**:
- `Photo`: Photo data model
- `Album`: Album data model
- `FamilyMember`: Family member data model
- `MemberPermissions`: Permission enumeration

**Key Characteristics**:
- Conform to `Identifiable` for SwiftUI
- Conform to `Codable` for persistence
- Conform to `Hashable` for collections
- Include computed properties
- Provide sample data for development

## Data Flow

### Read Flow (Top to Bottom)

1. **View** requests data display
2. **ViewModel** loads data from Service
3. **Service** fetches from storage (UserDefaults)
4. **Service** decodes to Models
5. **Models** returned to ViewModel
6. **ViewModel** updates `@Published` properties
7. **View** automatically re-renders

### Write Flow (Bottom to Top)

1. **View** triggers user action
2. **ViewModel** processes action
3. **ViewModel** calls Service method
4. **Service** creates/updates Model
5. **Service** persists to storage
6. **ViewModel** updates local state
7. **View** reflects changes

## State Management

### View State

Managed within views using:
- `@State`: Local view state
- `@Binding`: Two-way connections
- `@StateObject`: ViewModel ownership
- `@ObservedObject`: Passed ViewModels

### Global State

Currently no global state manager. Future considerations:
- App-wide settings
- Authentication state
- User session

## Dependency Management

### Current Approach

- **No external dependencies** for MVP
- System frameworks only:
  - SwiftUI for UI
  - Foundation for core functionality
  - Combine for reactive programming (implicit in SwiftUI)

### Dependency Injection

Services use singleton pattern:
```swift
class PhotoService {
    static let shared = PhotoService()
    private init() {}
}
```

ViewModels accept injected services:
```swift
init(photoService: PhotoService = PhotoService.shared) {
    self.photoService = photoService
}
```

Benefits:
- Easy testing with mock services
- Flexible configuration
- Clear dependencies

## Error Handling

### Strategy

1. **Service Layer**: Throws errors
2. **ViewModel Layer**: Catches and converts to user-friendly messages
3. **View Layer**: Displays error states

### Example

```swift
// Service
func fetchPhotos() async throws -> [Photo] {
    // Can throw errors
}

// ViewModel
func loadPhotos() {
    Task {
        do {
            photos = try await service.fetchPhotos()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

// View
if let error = viewModel.errorMessage {
    Text(error).foregroundColor(.red)
}
```

## Threading Model

### Main Thread (@MainActor)

- All ViewModels marked with `@MainActor`
- Ensures UI updates on main thread
- Safe property access from views

### Background Work

- Service operations use async/await
- Automatically managed by Swift concurrency
- No manual thread management needed

## Data Persistence

### Current Implementation

**UserDefaults** for MVP:
- Simple key-value storage
- Adequate for prototype
- Easy to migrate later

### Keys

- `studio360.photos`: Photo array
- `studio360.albums`: Album array
- `studio360.familyMembers`: Family member array

### Future Considerations

Options for production:
1. **Core Data**: Apple's ORM solution
2. **SQLite**: Direct SQL access
3. **Realm**: Third-party database
4. **CloudKit**: Apple's cloud storage
5. **Firebase**: Real-time database

## Security Considerations

### Current Implementation

- Local storage only
- No network communication
- Standard iOS app sandbox
- Keychain not yet utilized

### Future Enhancements

- Encrypt sensitive data
- Use Keychain for credentials
- Implement biometric authentication
- Add data backup encryption

## Testing Strategy

### Unit Tests

- Model tests: Initialization, Codable, business logic
- ViewModel tests: State management, user actions
- Service tests: CRUD operations (future)

### Integration Tests

- End-to-end flows (future)
- Data persistence (future)

### UI Tests

- User journeys (future)
- Accessibility (future)

## Performance Considerations

### Current Optimizations

- Lazy loading with `LazyVGrid`
- Efficient SwiftUI updates
- Minimal re-renders
- Lightweight models

### Future Optimizations

- Image caching
- Pagination for large datasets
- Background fetch
- Database indexing

## Scalability

### Current Scale

- Supports hundreds of photos
- Dozens of albums
- Small family groups (5-10 members)

### Future Scale Targets

- Thousands of photos
- Hundreds of albums
- Larger family networks (50+ members)
- Cloud synchronization

## Extension Points

### Easy to Add

1. **New Views**: Follow existing patterns
2. **New ViewModels**: Extend ObservableObject
3. **New Services**: Follow singleton pattern
4. **New Models**: Conform to Codable, Identifiable

### Plugin Architecture

Future consideration for:
- Custom themes
- Import/export plugins
- Third-party integrations

## Monitoring & Analytics

### Future Additions

- Crash reporting (Firebase Crashlytics)
- Analytics (Google Analytics, Mixpanel)
- Performance monitoring
- User behavior tracking (with consent)

## Documentation Standards

### Code Documentation

- Public APIs documented with ///
- Complex algorithms explained
- Example usage provided
- Edge cases noted

### Architecture Documentation

- This document for overall architecture
- README for getting started
- TESTING.md for testing approach
- CONTRIBUTING.md for development guidelines

## Best Practices Followed

1. **Separation of Concerns**: Each layer has distinct responsibility
2. **DRY Principle**: Reusable components and services
3. **SOLID Principles**: Clean, maintainable code
4. **SwiftUI Best Practices**: Efficient view updates
5. **Swift Concurrency**: Modern async/await patterns
6. **Error Handling**: Comprehensive error management
7. **Testing**: Testable architecture with dependency injection

## Conclusion

This architecture provides a solid foundation for Studio 360°, balancing simplicity for MVP with extensibility for future growth. The MVVM pattern with SwiftUI ensures maintainability, testability, and a responsive user experience.
