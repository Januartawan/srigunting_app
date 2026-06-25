#!/bin/bash

# Usage: ./build_apk.sh [staging|production]
# Default: staging

ENV=${1:-staging}

if [ "$ENV" = "production" ]; then
  API_URL="http://103.166.195.193:1702"
else
  API_URL="http://103.166.195.193:1706"
fi

echo "Building APK for $ENV environment..."
flutter build apk --release --split-per-abi --dart-define=API_URL=$API_URL

echo "Build complete. Output files:"
echo "- ARM64: build/app/outputs/flutter-apk/app-arm64-v8a-release.apk"
echo "- ARM32: build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk"
echo "- x86_64: build/app/outputs/flutter-apk/app-x86_64-release.apk" 