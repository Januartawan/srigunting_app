# Bali Bird Park Mobile - Flutter Makefile
# Author: Development Team
# Description: Makefile untuk menjalankan dan build aplikasi Flutter

# Variables
APP_NAME = srigunting_app
FLUTTER = flutter
DART = dart

# Entry points
ANDROID_ENTRY = lib/cmd/android.dart
IOS_ENTRY = lib/cmd/ios.dart
WEB_ENTRY = lib/cmd/web.dart

# Build configurations
BUILD_NAME = 1.0.0
BUILD_NUMBER = 1

# Colors for output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[0;34m
NC = \033[0m # No Color

# Tambahkan variabel DART_DEFINES
DART_DEFINES ?= API_URL=http://103.166.195.193:1706

# Helper untuk mengubah DART_DEFINES menjadi --dart-define=KEY=VALUE
# Jika DART_DEFINES tidak kosong, akan diubah menjadi --dart-define=KEY=VALUE untuk setiap pasangan
ifneq ($(strip $(DART_DEFINES)),)
  DART_DEFINE_FLAGS := $(foreach def,$(subst ",,$(DART_DEFINES)),--dart-define=$(def))
else
  DART_DEFINE_FLAGS :=
endif

.PHONY: help clean get pub-get pub-upgrade analyze test build-runner generate-icons build-android build-ios build-web run-android run-ios run-web debug-android debug-ios debug-web test-build test-network test-network-android run-with-logging

# Default target
help:
	@echo "$(BLUE)Bali Bird Park Mobile - Flutter Commands$(NC)"
	@echo ""
	@echo "$(GREEN)Development Commands:$(NC)"
	@echo "  make get          - Install dependencies"
	@echo "  make pub-get      - Run flutter pub get"
	@echo "  make pub-upgrade  - Upgrade dependencies"
	@echo "  make analyze      - Run code analysis"
	@echo "  make test         - Run tests"
	@echo "  make clean        - Clean build cache"
	@echo ""
	@echo "$(GREEN)Build Runner Commands:$(NC)"
	@echo "  make build-runner - Run build_runner for code generation"
	@echo "  make generate-icons - Generate launcher icons"
	@echo ""
	@echo "$(GREEN)Run Commands:$(NC)"
	@echo "  make run-android  - Run on Android device/emulator"
	@echo "  make run-ios      - Run on iOS device/simulator"
	@echo "  make run-web      - Run on web browser"
	@echo "  make run-with-logging - Run with detailed network logging"
	@echo ""
	@echo "$(GREEN)Debug Commands:$(NC)"
	@echo "  make debug-android - Debug on Android"
	@echo "  make debug-ios     - Debug on iOS"
	@echo "  make debug-web     - Debug on web"
	@echo ""
	@echo "$(GREEN)Build Commands:$(NC)"
	@echo "  make build-android - Build APK for Android"
	@echo "  make build-ios     - Build for iOS"
	@echo "  make build-web     - Build for web"
	@echo "  make test-build    - Test build with debug mode"
	@echo ""
	@echo "$(GREEN)Testing Commands:$(NC)"
	@echo "  make test-network  - Test network connectivity"
	@echo "  make test-network-android - Test network on Android device"
	@echo ""
	@echo "$(GREEN)Environment Variables:$(NC)"
	@echo "  DART_DEFINES      - Set dart-define flags (default: API_URL=http://103.166.195.193:1706)"
	@echo "  Example: make run-web DART_DEFINES=\"API_URL=https://api.example.com\""
	@echo "  Example: make run-android DART_DEFINES=\"API_URL=https://api.example.com,ENV=production\""
	@echo ""

# Development commands
get: pub-get
	@echo "$(GREEN)✓ Dependencies installed$(NC)"

pub-get:
	@echo "$(BLUE)Installing dependencies...$(NC)"
	$(FLUTTER) pub get

pub-upgrade:
	@echo "$(BLUE)Upgrading dependencies...$(NC)"
	$(FLUTTER) pub upgrade

analyze:
	@echo "$(BLUE)Running code analysis...$(NC)"
	$(FLUTTER) analyze

test:
	@echo "$(BLUE)Running tests...$(NC)"
	$(FLUTTER) test

clean:
	@echo "$(BLUE)Cleaning build cache...$(NC)"
	$(FLUTTER) clean
	$(FLUTTER) pub get

# Build runner for code generation (kiwi, build_runner, etc.)
build-runner:
	@echo "$(BLUE)Running build_runner...$(NC)"
	$(FLUTTER) packages pub run build_runner build --delete-conflicting-outputs

build-runner-watch:
	@echo "$(BLUE)Running build_runner in watch mode...$(NC)"
	$(FLUTTER) packages pub run build_runner watch --delete-conflicting-outputs

# Generate launcher icons
generate-icons:
	@echo "$(BLUE)Generating launcher icons...$(NC)"
	$(FLUTTER) pub run flutter_launcher_icons:main

# Run commands
run-android:
	@echo "$(BLUE)Running on Android...$(NC)"
	$(FLUTTER) run -t $(ANDROID_ENTRY) --flavor dev $(DART_DEFINE_FLAGS)

run-ios:
	@echo "$(BLUE)Running on iOS...$(NC)"
	$(FLUTTER) run -t $(IOS_ENTRY) --flavor dev $(DART_DEFINE_FLAGS)

run-web:
	@echo "$(BLUE)Running on web...$(NC)"
	$(FLUTTER) run -t $(WEB_ENTRY) -d chrome $(DART_DEFINE_FLAGS)

# Debug commands
debug-android:
	@echo "$(BLUE)Debugging on Android...$(NC)"
	$(FLUTTER) run -t $(ANDROID_ENTRY) --flavor dev --debug $(DART_DEFINE_FLAGS)

debug-ios:
	@echo "$(BLUE)Debugging on iOS...$(NC)"
	$(FLUTTER) run -t $(IOS_ENTRY) --flavor dev --debug $(DART_DEFINE_FLAGS)

debug-web:
	@echo "$(BLUE)Debugging on web...$(NC)"
	$(FLUTTER) run -t $(WEB_ENTRY) -d chrome --debug $(DART_DEFINE_FLAGS)

# Build commands
build-android:
	@echo "$(BLUE)Building APK for Android...$(NC)"
	$(FLUTTER) build apk -t $(ANDROID_ENTRY) --build-name=$(BUILD_NAME) --build-number=$(BUILD_NUMBER) $(DART_DEFINE_FLAGS)

build-android-release:
	@echo "$(BLUE)Building release APK for Android...$(NC)"
	$(FLUTTER) build apk --release -t $(ANDROID_ENTRY) --build-name=$(BUILD_NAME) --build-number=$(BUILD_NUMBER) $(DART_DEFINE_FLAGS)

build-ios:
	@echo "$(BLUE)Building for iOS...$(NC)"
	$(FLUTTER) build ios -t $(IOS_ENTRY) --build-name=$(BUILD_NAME) --build-number=$(BUILD_NUMBER) $(DART_DEFINE_FLAGS)

build-web:
	@echo "$(BLUE)Building for web...$(NC)"
	$(FLUTTER) build web -t $(WEB_ENTRY) --build-name=$(BUILD_NAME) --build-number=$(BUILD_NUMBER) $(DART_DEFINE_FLAGS)

# Device management
devices:
	@echo "$(BLUE)Available devices:$(NC)"
	$(FLUTTER) devices

# Doctor command for troubleshooting
doctor:
	@echo "$(BLUE)Running Flutter doctor...$(NC)"
	$(FLUTTER) doctor

# Format code
format:
	@echo "$(BLUE)Formatting code...$(NC)"
	$(FLUTTER) format lib/

# Lint code
lint:
	@echo "$(BLUE)Linting code...$(NC)"
	$(FLUTTER) analyze --no-fatal-infos

# Quick setup for new developers
setup: get build-runner
	@echo "$(GREEN)✓ Project setup complete!$(NC)"
	@echo "$(YELLOW)Run 'make help' to see all available commands$(NC)"

# Test build with better error handling
test-build:
	@echo "$(BLUE)Testing build with error handling...$(NC)"
	$(FLUTTER) build apk -t $(ANDROID_ENTRY) --debug $(DART_DEFINE_FLAGS)

# Test network connectivity
test-network:
	@echo "$(BLUE)Testing network connectivity...$(NC)"
	@curl -I http://103.166.195.193:1706
	@echo "$(GREEN)✓ Network test completed$(NC)"

# Test network on Android device
test-network-android:
	@echo "$(BLUE)Testing network on Android device...$(NC)"
	@adb shell ping -c 3 103.166.195.193
	@echo "$(GREEN)✓ Android network test completed$(NC)"

# Run with detailed logging for debugging
run-with-logging:
	@echo "$(BLUE)Running with detailed network logging...$(NC)"
	$(FLUTTER) run -t $(ANDROID_ENTRY) --flavor dev $(DART_DEFINE_FLAGS) --verbose

# Hot reload helper
reload:
	@echo "$(BLUE)Triggering hot reload...$(NC)"
	@echo "r" | $(FLUTTER) run

# Hot restart helper
restart:
	@echo "$(BLUE)Triggering hot restart...$(NC)"
	@echo "R" | $(FLUTTER) run
