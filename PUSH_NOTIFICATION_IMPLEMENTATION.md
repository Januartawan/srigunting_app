# Push Notification Implementation

## Overview

Implementasi lengkap push notification menggunakan Firebase Cloud Messaging (FCM) untuk menampilkan notifikasi ketika ada pesan yang di-push dari backend. Implementasi ini terintegrasi dengan device token API yang sudah ada sebelumnya.

## Features

- ✅ **Foreground Notifications**: Menampilkan notifikasi saat app terbuka
- ✅ **Background Notifications**: Menampilkan notifikasi saat app di background
- ✅ **Terminated State Notifications**: Menampilkan notifikasi saat app ditutup
- ✅ **In-App Notifications**: Menampilkan snackbar/flushbar untuk notifikasi foreground
- ✅ **Navigation Handling**: Navigasi otomatis berdasarkan data notifikasi
- ✅ **Topic Subscription**: Subscribe/unsubscribe ke topic tertentu
- ✅ **Platform Detection**: Otomatis detect platform (Android/iOS)

## Files Created/Modified

### 1. New Files

- **`lib/src/infrastructure/services/firebase_messaging_service.dart`**: Service utama untuk menangani Firebase Messaging
- **`android/app/src/main/res/values/colors.xml`**: Color resources untuk notification
- **`PUSH_NOTIFICATION_IMPLEMENTATION.md`**: Dokumentasi implementasi

### 2. Modified Files

- **`lib/cmd/android.dart`**: Initialize Firebase dan Firebase Messaging Service
- **`lib/src/ui/app/home/home_screen.dart`**: Update untuk menggunakan FirebaseMessagingService
- **`android/app/src/main/AndroidManifest.xml`**: Tambah permission dan service untuk notification
- **`ios/Runner/Info.plist`**: Tambah background modes dan Firebase configuration

## Firebase Messaging Service

### Key Features

```dart
class FirebaseMessagingService {
  // Initialize Firebase Messaging
  Future<void> initialize()

  // Get FCM token
  Future<String?> getToken()

  // Subscribe to topic
  Future<void> subscribeToTopic(String topic)

  // Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic)

  // Get platform info
  String getPlatform()
}
```

### Message Handlers

1. **Foreground Handler**: `_handleForegroundMessage()`

   - Menampilkan in-app notification menggunakan Flushbar
   - Log message details untuk debugging

2. **Background Handler**: `firebaseMessagingBackgroundHandler()`

   - Top-level function untuk menangani background messages
   - Dapat digunakan untuk update local database, show local notification, dll

3. **Message Opened Handler**: `_handleMessageOpenedApp()`
   - Menangani navigation ketika user tap notification
   - Support custom routing berdasarkan data payload

## Android Configuration

### Permissions Added

```xml
<!-- Notification permissions -->
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.VIBRATE" />

<!-- Firebase Cloud Messaging -->
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
```

### Services Added

```xml
<!-- Firebase Cloud Messaging Service -->
<service
    android:name="io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingService"
    android:exported="false">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT" />
    </intent-filter>
</service>
```

### Notification Configuration

```xml
<!-- Default notification channel -->
<meta-data
    android:name="com.google.firebase.messaging.default_notification_channel_id"
    android:value="srigunting_notifications" />

<!-- Default notification icon -->
<meta-data
    android:name="com.google.firebase.messaging.default_notification_icon"
    android:resource="@mipmap/ic_launcher" />

<!-- Default notification color -->
<meta-data
    android:name="com.google.firebase.messaging.default_notification_color"
    android:resource="@color/colorAccent" />
```

## iOS Configuration

### Background Modes

```xml
<key>UIBackgroundModes</key>
<array>
    <string>remote-notification</string>
    <string>background-fetch</string>
</array>
```

### Firebase Configuration

```xml
<key>FirebaseAppDelegateProxyEnabled</key>
<false/>
```

## Usage Examples

### 1. Initialize Service

```dart
// Di main.dart
await FirebaseMessagingService().initialize();
```

### 2. Get Device Token

```dart
String? token = await FirebaseMessagingService().getToken();
```

### 3. Subscribe to Topic

```dart
await FirebaseMessagingService().subscribeToTopic('general');
await FirebaseMessagingService().subscribeToTopic('promotions');
```

### 4. Handle Custom Navigation

```dart
// Di _handleNotificationNavigation()
if (data.containsKey('route')) {
  final route = data['route'];
  // Navigate to specific route
  Navigator.pushNamed(context, route);
}
```

## Notification Payload Format

### Basic Notification

```json
{
  "notification": {
    "title": "Notification Title",
    "body": "Notification Body"
  },
  "data": {
    "route": "/home",
    "action": "show_qr"
  }
}
```

### Advanced Notification

```json
{
  "notification": {
    "title": "New Promotion!",
    "body": "Check out our latest offers",
    "image": "https://example.com/image.jpg"
  },
  "data": {
    "route": "/promotions",
    "promotion_id": "123",
    "action": "view_promotion"
  }
}
```

## Testing

### 1. Test Foreground Notifications

1. Buka app dan pastikan di foreground
2. Kirim test notification dari Firebase Console
3. Verifikasi in-app notification muncul

### 2. Test Background Notifications

1. Minimize app (jangan close)
2. Kirim test notification
3. Verifikasi system notification muncul

### 3. Test Terminated State Notifications

1. Close app completely
2. Kirim test notification
3. Tap notification dan verifikasi app terbuka

### 4. Test Navigation

1. Kirim notification dengan data payload
2. Tap notification
3. Verifikasi navigation berfungsi

## Firebase Console Setup

### 1. Create Notification Channel (Android)

1. Buka Firebase Console
2. Go to Cloud Messaging
3. Create notification channel dengan ID: `srigunting_notifications`

### 2. Test Notifications

1. Go to Cloud Messaging > Send your first message
2. Fill title dan body
3. Select target (device token atau topic)
4. Send test message

### 3. Advanced Targeting

- **By Token**: Kirim ke device token spesifik
- **By Topic**: Kirim ke semua device yang subscribe topic
- **By Condition**: Kirim berdasarkan kondisi tertentu

## Error Handling

### Common Issues

1. **Token Not Generated**

   - Check Firebase configuration
   - Verify Google Services file (Android)
   - Check iOS provisioning profile

2. **Notifications Not Received**

   - Check device permissions
   - Verify notification channel (Android)
   - Check background app refresh (iOS)

3. **Navigation Not Working**
   - Check route names
   - Verify navigation context
   - Check data payload format

### Debug Logs

```dart
// Enable debug logging
if (kDebugMode) {
  print('FCM Token: $token');
  print('Message received: ${message.notification?.title}');
  print('Navigation data: ${message.data}');
}
```

## Security Considerations

1. **Token Security**: Device token tidak boleh disimpan di client side
2. **Data Validation**: Validasi semua data dari notification payload
3. **Permission Handling**: Handle permission denied gracefully
4. **Rate Limiting**: Implement rate limiting untuk prevent spam

## Performance Optimization

1. **Lazy Loading**: Initialize service hanya saat diperlukan
2. **Memory Management**: Dispose listeners saat tidak diperlukan
3. **Background Processing**: Minimize background processing
4. **Network Efficiency**: Batch API calls jika memungkinkan

## Next Steps

1. **Custom Notification UI**: Implement custom notification layout
2. **Rich Notifications**: Support image, action buttons, dll
3. **Analytics Integration**: Track notification engagement
4. **A/B Testing**: Test different notification strategies
5. **Local Notifications**: Implement local notification scheduling

## Troubleshooting

### Android Issues

- Check `google-services.json` file
- Verify notification permissions
- Check notification channel configuration
- Test on different Android versions

### iOS Issues

- Check `GoogleService-Info.plist` file
- Verify push notification capabilities
- Check provisioning profile
- Test on different iOS versions

### General Issues

- Check Firebase project configuration
- Verify API keys and certificates
- Check network connectivity
- Review Firebase Console logs
