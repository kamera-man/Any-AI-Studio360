# Studio 360° Testing Guide

## Overview

This document describes the testing strategy for the Studio 360° iOS application.

## Test Structure

### Unit Tests

Located in `Studio360Tests/`, these tests verify individual components:

#### Model Tests
- `PhotoTests.swift` - Tests for Photo model
- `AlbumTests.swift` - Tests for Album model
- `FamilyMemberTests.swift` - Tests for FamilyMember model

**Coverage:**
- Initialization
- Property validation
- Codable conformance
- Sample data generation
- Business logic (permissions, counts, etc.)

#### ViewModel Tests
- `PhotoLibraryViewModelTests.swift` - Tests for PhotoLibraryViewModel
- `AlbumViewModelTests.swift` - Tests for AlbumViewModel

**Coverage:**
- Data loading
- State management
- Search and filtering
- CRUD operations
- Error handling
- Async operations

### Test Coverage Goals

- **Models**: 90%+ coverage
- **ViewModels**: 80%+ coverage
- **Services**: 75%+ coverage
- **Overall**: 70%+ coverage

## Running Tests

### In Xcode

1. Open `Studio360.xcodeproj`
2. Press `⌘U` to run all tests
3. Or click Product > Test

### Command Line

```bash
# Run all tests (requires xcodebuild)
xcodebuild test -scheme Studio360 -destination 'platform=iOS Simulator,name=iPhone 15'

# Run specific test
xcodebuild test -scheme Studio360 -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:Studio360Tests/PhotoTests
```

### Viewing Results

- Test results appear in the Test Navigator (⌘6)
- Code coverage can be viewed in the Report Navigator (⌘9)
- Failed tests show inline in the editor

## Test Best Practices

### Naming Convention

```swift
func test{Feature}{Condition}{ExpectedBehavior}()
```

Examples:
- `testPhotoInitialization()`
- `testSearchFilterWithValidQuery()`
- `testDeletePhotoRemovesFromList()`

### Test Structure (Arrange-Act-Assert)

```swift
func testExample() {
    // Given (Arrange)
    let input = "test"
    
    // When (Act)
    let result = function(input)
    
    // Then (Assert)
    XCTAssertEqual(result, expected)
}
```

### Async Testing

```swift
@MainActor
func testAsyncOperation() async throws {
    // Given
    let viewModel = ViewModel()
    
    // When
    try await Task.sleep(nanoseconds: 600_000_000)
    
    // Then
    XCTAssertFalse(viewModel.isLoading)
}
```

## Test Data

### Sample Data
All models provide sample data for testing:
- `Photo.samplePhotos`
- `Album.sampleAlbums`
- `FamilyMember.sampleMembers`

### Test Fixtures
For integration tests, use:
- Clean UserDefaults before each test
- Predictable UUIDs when needed
- Fixed dates for time-dependent tests

## Code Coverage

### Enabling Coverage

1. Edit Scheme (⌘<)
2. Select Test
3. Check "Gather coverage for all targets"
4. Or specific targets only

### Viewing Coverage

1. Run tests with coverage enabled
2. Open Report Navigator (⌘9)
3. Select latest test run
4. Click Coverage tab

### Coverage Reports

Generate coverage reports:
```bash
xcodebuild test -scheme Studio360 \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  -enableCodeCoverage YES \
  -derivedDataPath ./DerivedData
```

## Continuous Integration

### GitHub Actions Example

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run tests
        run: |
          xcodebuild test \
            -scheme Studio360 \
            -destination 'platform=iOS Simulator,name=iPhone 15' \
            -enableCodeCoverage YES
```

## UI Tests

UI tests would go in `Studio360UITests/` (not yet implemented):

### Example UI Test Structure

```swift
class Studio360UITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testTabNavigation() {
        // Test switching between tabs
        app.tabBars.buttons["Albums"].tap()
        XCTAssertTrue(app.navigationBars["Albums"].exists)
    }
}
```

## Performance Tests

### Example Performance Test

```swift
func testPhotoLoadingPerformance() {
    measure {
        // Code to measure
        _ = viewModel.filteredPhotos
    }
}
```

### Baseline Management

1. Run performance test first time
2. Click "Set Baseline" in test results
3. Future runs compare against baseline
4. Update baseline when expected changes occur

## Troubleshooting

### Common Issues

**Tests not appearing:**
- Clean build folder (⌘⇧K)
- Rebuild (⌘B)
- Restart Xcode

**Async tests timing out:**
- Increase sleep duration
- Check for actual delays in code
- Use XCTestExpectation for precise control

**Coverage not showing:**
- Enable coverage in scheme
- Clean derived data
- Rebuild and rerun tests

## Future Testing Plans

### Integration Tests
- [ ] Test service layer with real data
- [ ] Test data persistence
- [ ] Test error scenarios

### UI Tests
- [ ] Critical user flows
- [ ] Navigation testing
- [ ] Accessibility testing

### Performance Tests
- [ ] Photo grid scrolling
- [ ] Album loading
- [ ] Search performance

### Snapshot Tests
- [ ] View rendering
- [ ] Layout variations
- [ ] Dark mode support

## Resources

- [XCTest Documentation](https://developer.apple.com/documentation/xctest)
- [Testing Your Apps in Xcode](https://developer.apple.com/documentation/xcode/testing-your-apps-in-xcode)
- [Writing Testable Code](https://developer.apple.com/documentation/xcode/writing-testable-code)

## Test Metrics

Current Status:
- ✅ Model tests: Complete
- ✅ ViewModel tests: Complete
- ⏳ Service tests: Pending
- ⏳ UI tests: Pending
- ⏳ Integration tests: Pending

Target Coverage: 70%+
Current Coverage: To be measured
