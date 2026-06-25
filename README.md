# Bali Bird Park Mobile

A Flutter application for Bali Bird Park mobile app.

## Project Structure

```
lib/
├── cmd/                    # Entry points for different platforms
│   ├── android.dart       # Android entry point
│   ├── ios.dart          # iOS entry point
│   ├── web.dart          # Web entry point
│   └── app.dart          # Base app class
├── src/
│   ├── domain/           # Business logic layer
│   ├── infrastructure/   # Infrastructure layer (UI, services, etc.)
│   ├── repository/       # Data layer
│   └── ui/              # Presentation layer
```

## Getting Started

### Prerequisites

- Flutter SDK (^3.5.4)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Chrome (for web development)

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   make get
   # or
   flutter pub get
   ```

3. Run build_runner for code generation:
   ```bash
   make build-runner
   # or
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

## Development with Makefile

This project includes a comprehensive Makefile for easier development workflow.

### Available Commands

#### Development Commands
```bash
make get          # Install dependencies
make pub-get      # Run flutter pub get
make pub-upgrade  # Upgrade dependencies
make analyze      # Run code analysis
make test         # Run tests
make clean        # Clean build cache
```

#### Build Runner Commands
```bash
make build-runner      # Run build_runner for code generation
make build-runner-watch # Run build_runner in watch mode
```

#### Run Commands
```bash
make run-android  # Run on Android device/emulator
make run-ios      # Run on iOS device/simulator
make run-web      # Run on web browser
```

#### Debug Commands
```bash
make debug-android # Debug on Android
make debug-ios     # Debug on iOS
make debug-web     # Debug on web
```

#### Build Commands
```bash
make build-android       # Build APK for Android
make build-android-release # Build release APK for Android
make build-ios           # Build for iOS
make build-web           # Build for web
```

#### Utility Commands
```bash
make devices     # List available devices
make doctor      # Run Flutter doctor
make format      # Format code
make lint        # Lint code
make setup       # Quick setup for new developers
```

### Quick Start

1. **Setup project:**
   ```bash
   make setup
   ```

2. **Run on web (recommended for development):**
   ```bash
   make run-web
   ```

3. **Run on Android:**
   ```bash
   make run-android
   ```

4. **Run on iOS:**
   ```bash
   make run-ios
   ```

### Entry Points

The application uses different entry points for different platforms:

- **Android**: `lib/cmd/android.dart`
- **iOS**: `lib/cmd/ios.dart`
- **Web**: `lib/cmd/web.dart`
- **Default**: `lib/main.dart` (uses Android entry point)

### Architecture

This project follows Clean Architecture principles:

- **Domain Layer**: Business logic and entities
- **Data Layer**: Repositories and data sources
- **Presentation Layer**: UI components and state management

### State Management

The project uses BLoC pattern for state management with the following structure:
- Events: Define actions that can be performed
- States: Define the possible states of the application
- BLoCs: Handle the business logic and state transitions

### Dependencies

Key dependencies:
- `flutter_bloc`: State management
- `kiwi`: Dependency injection
- `dio`: HTTP client
- `flutter_secure_storage`: Secure storage
- `qr_flutter`: QR code generation
- `intl`: Internationalization

## Troubleshooting

### Common Issues

1. **Build Runner Issues:**
   ```bash
   make clean
   make build-runner
   ```

2. **Dependency Issues:**
   ```bash
   make clean
   make get
   ```

3. **Analysis Issues:**
   ```bash
   make analyze
   ```

4. **Network Error Handling:**
   - Fixed null pointer exception in `responseHandler`
   - Added proper error message handling
   - Improved logging for debugging

5. **Icon Issues:**
   ```bash
   make generate-icons
   ```

### Error Handling Improvements

The application now has improved error handling for network requests:

- **Null Safety**: Fixed `NoSuchMethodError` when accessing null error responses
- **Better Error Messages**: More descriptive error messages for debugging
- **Logging**: Enhanced logging for network errors
- **Fallback Values**: Default error messages when response is null

### Network Error Troubleshooting

If you encounter network errors after building the app:

1. **Test Network Connectivity:**
   ```bash
   make test-network
   ```

2. **Test Network on Android Device:**
   ```bash
   make test-network-android
   ```

3. **Run with Detailed Logging:**
   ```bash
   make run-with-logging
   ```

4. **Check API Configuration:**
   - Verify API URL in `lib/src/env.dart`
   - Test API endpoints manually with curl
   - Check server status and connectivity

5. **Common Network Issues:**
   - **SSL Certificate**: Server uses HTTP (not HTTPS)
   - **Timeout**: Increased timeout to 60 seconds
   - **CORS**: API supports cross-origin requests
   - **Authentication**: Check if auth token is required
   - **Android Permissions**: Added INTERNET and ACCESS_NETWORK_STATE permissions
   - **HTTP Traffic**: Enabled cleartext traffic for development

6. **Connection Error Solutions:**
   - **Retry Logic**: Added automatic retry for connection errors
   - **Network Security**: Configured network security for HTTP traffic
   - **Timeout Increase**: Extended timeout to 60 seconds
   - **Follow Redirects**: Enabled redirect following

7. **Debug Network Requests:**
   - Network logging is enabled in debug mode
   - Check console for detailed request/response logs
   - Verify headers and authentication tokens

### Getting Help

Run `make help` to see all available commands.

## Contributing

1. Follow the existing code structure and patterns
2. Use the Makefile commands for development
3. Run analysis before committing: `make analyze`
4. Format code: `make format`

## License

This project is proprietary software for Bali Bird Park.
