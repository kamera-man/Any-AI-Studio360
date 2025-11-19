# AI Branch Creation Instructions

## Overview

This document provides instructions for AI agents working on the Studio 360° iOS application. Follow these guidelines to ensure consistent, high-quality contributions.

## Branch Naming Convention

Use descriptive branch names that follow this pattern:
- `feature/{feature-name}` - For new features
- `bugfix/{bug-description}` - For bug fixes
- `refactor/{component-name}` - For code refactoring
- `docs/{documentation-type}` - For documentation updates

Examples:
- `feature/photo-grid-view`
- `feature/album-management`
- `bugfix/crash-on-photo-load`
- `refactor/view-model-structure`

## Development Workflow

### 1. Understanding the Task
- Read the specification documents thoroughly
- Understand the feature requirements
- Identify dependencies and prerequisites
- Plan the implementation approach

### 2. Setting Up Your Environment
- Ensure Xcode is properly installed
- Verify Swift version compatibility
- Check for required dependencies
- Review existing codebase

### 3. Implementation Steps

#### Step 1: Create Models
- Define data structures
- Implement Codable protocols
- Add proper documentation
- Include example usage

#### Step 2: Create ViewModels
- Implement MVVM pattern
- Use ObservableObject protocol
- Handle state management
- Add error handling

#### Step 3: Create Views
- Build SwiftUI views
- Follow HIG guidelines
- Implement responsive design
- Add accessibility features

#### Step 4: Integrate Services
- Create service layer if needed
- Handle async operations
- Implement proper error handling
- Add logging for debugging

### 4. Code Quality Checklist

Before committing code, ensure:
- [ ] Code compiles without errors or warnings
- [ ] All new code has proper documentation
- [ ] Unit tests are written and passing
- [ ] No force unwrapping without guards
- [ ] Proper error handling is implemented
- [ ] Memory management is correct (no retain cycles)
- [ ] Code follows Swift style guidelines
- [ ] Accessibility is considered
- [ ] Performance is optimized

### 5. Testing Requirements

#### Unit Tests
- Test ViewModels thoroughly
- Test business logic
- Test data models
- Aim for 70%+ coverage

#### UI Tests
- Test critical user flows
- Test navigation
- Test user interactions
- Verify accessibility

#### Manual Testing
- Test on simulator
- Test on real device if possible
- Test different iOS versions
- Test different screen sizes

### 6. Documentation

Each feature should include:
- Code comments for complex logic
- README updates if needed
- API documentation
- Usage examples

### 7. Commit Guidelines

Use conventional commits format:
```
type(scope): subject

body

footer
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

Examples:
```
feat(photos): add photo grid view with lazy loading

- Implement LazyVGrid for efficient rendering
- Add pull-to-refresh functionality
- Include loading indicators

Closes #123
```

### 8. Code Review Process

When submitting code for review:
- Provide clear description of changes
- Explain technical decisions
- Highlight any breaking changes
- Include screenshots for UI changes
- Reference related issues

### 9. Common Patterns

#### SwiftUI Views
```swift
struct ExampleView: View {
    @StateObject private var viewModel = ExampleViewModel()
    
    var body: some View {
        NavigationView {
            // View content
        }
        .navigationTitle("Title")
    }
}

#if DEBUG
struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
#endif
```

#### ViewModels
```swift
@MainActor
class ExampleViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadItems() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            items = try await fetchItems()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
```

#### Models
```swift
struct Item: Identifiable, Codable {
    let id: UUID
    let name: String
    let createdAt: Date
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.createdAt = Date()
    }
}
```

### 10. Error Handling Pattern

Always handle errors gracefully:
```swift
do {
    let result = try await performOperation()
    // Handle success
} catch let error as CustomError {
    // Handle specific error
} catch {
    // Handle general error
    print("Error: \(error.localizedDescription)")
}
```

### 11. Performance Guidelines

- Use lazy loading for large collections
- Avoid blocking the main thread
- Optimize image loading and caching
- Profile with Instruments regularly
- Monitor memory usage

### 12. Security Best Practices

- Never hardcode sensitive data
- Use Keychain for credentials
- Validate all user input
- Follow OWASP mobile security guidelines
- Implement proper authentication

### 13. Accessibility Guidelines

- Add accessibility labels
- Support VoiceOver
- Support Dynamic Type
- Ensure minimum touch targets
- Test with accessibility features enabled

### 14. Debugging Tips

- Use print statements sparingly
- Leverage Xcode debugger
- Use breakpoints effectively
- Monitor console logs
- Use Instruments for profiling

### 15. Final Checklist

Before marking a feature as complete:
- [ ] All requirements met
- [ ] Code reviewed and approved
- [ ] Tests passing
- [ ] Documentation updated
- [ ] No compiler warnings
- [ ] Performance validated
- [ ] Accessibility verified
- [ ] Security reviewed
- [ ] Ready for merge

## Resources

- [Swift Programming Language Guide](https://docs.swift.org/swift-book/)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)

## Questions?

If you're unsure about any implementation detail:
1. Review existing code for patterns
2. Check the specification documents
3. Consult Apple documentation
4. Ask for clarification before proceeding

Remember: **Quality over speed**. Take time to do it right the first time.
