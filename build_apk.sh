#!/bin/bash

# Usage: ./build_apk.sh [staging|production]
# Default: staging

ENV=${1:-production}

if [ "$ENV" = "production" ]; then
  API_URL="https://crm.balibirdpark.com"
else
  API_URL="https://stagingcrm.balibirdpark.com"
fi

echo "Building APK for $ENV environment..."
flutter build apk --release --split-per-abi --dart-define=API_URL=$API_URL

echo "Build complete. Output files:"
echo "- ARM64: build/app/outputs/flutter-apk/app-arm64-v8a-release.apk"
echo "- ARM32: build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk"
echo "- x86_64: build/app/outputs/flutter-apk/app-x86_64-release.apk" 