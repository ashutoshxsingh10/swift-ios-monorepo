# Contributing to Swift iOS Components Monorepo

Thank you for your interest in contributing! This document outlines guidelines for working with this monorepo.

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ashutoshxsingh10/swift-ios-monorepo.git
   cd swift-ios-monorepo
   ```

2. **Create a branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes** in the appropriate project directory

4. **Test thoroughly** in Xcode before submitting changes

## Development Guidelines

### Code Style
- Follow Swift style guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions focused and concise

### Project-Specific Guidelines

Each project may have additional requirements. Check the individual project directories for:
- `README.md` - Project overview
- `CONTRIBUTING.md` - Project-specific guidelines (if exists)
- `.swift-version` or version requirements

### Commit Messages

Write clear, descriptive commit messages:
- Use present tense: "Add feature" not "Added feature"
- Start with a capital letter
- Keep the first line under 50 characters
- Reference related issues when applicable

Example:
```
Add confetti animation customization options

- Allow color palette customization
- Support for different particle sizes
- Configurable animation duration

Fixes #123
```

## Pull Request Process

1. **Before submitting:**
   - Ensure your code builds without errors
   - Test on actual devices or simulators
   - Update documentation if needed
   - Verify no hardcoded values or debug code

2. **Create a pull request:**
   - Use a descriptive title
   - Reference related issues
   - Explain the changes and why they're needed
   - Include before/after screenshots for UI changes

3. **Code review:**
   - Address feedback promptly
   - Make requested changes in new commits
   - Ensure CI/CD checks pass

4. **Merging:**
   - PRs will be merged after approval
   - Use "Squash and merge" for single-commit PRs
   - Use "Create a merge commit" to preserve history for larger changes

## Working with Individual Projects

### Adding a New Component

1. Create a new directory at the repo root: `/NewComponent`
2. Include a `README.md` with:
   - Description
   - Installation instructions
   - Usage examples
   - Requirements
3. Include all source files, tests, and documentation
4. Update the main `README.md` and `PROJECTS.md`

### Updating Existing Components

- Keep backward compatibility when possible
- Document breaking changes clearly
- Update version numbers appropriately
- Test with dependent projects

## Testing

- Include unit tests where applicable
- Test on multiple iOS versions if possible
- Include UI tests for visual components
- Run all tests before submitting PR

## Documentation

- Update `README.md` in the project directory
- Add inline code comments for complex logic
- Include usage examples in documentation
- Keep documentation up-to-date with changes

## Issues

### Reporting Bugs

Include:
- Clear description of the bug
- Steps to reproduce
- Expected behavior
- Actual behavior
- Environment (Xcode version, iOS version, etc.)
- Screenshots/videos if applicable

### Suggesting Enhancements

Include:
- Clear description of the feature
- Motivation and use cases
- Possible implementation approach
- Mock-ups or examples if applicable

## Questions?

- Check existing issues and documentation
- Create a new issue with the question tag
- Be respectful and constructive

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Follow Swift community guidelines
- Report inappropriate behavior

---

Thank you for contributing to making this monorepo better!
