# Push Notification Testing Guide

## Prerequisites

Sebelum melakukan testing, pastikan:

1. ✅ Firebase project sudah dikonfigurasi dengan benar
2. ✅ `google-services.json` (Android) dan `GoogleService-Info.plist` (iOS) sudah ditambahkan
3. ✅ Device token API sudah berfungsi
4. ✅ App sudah di-build dan di-install di device

## Testing Steps

### 1. Test Device Token Generation

1. **Buka app** dan navigasi ke Home Screen
2. **Check console logs** untuk melihat:
   ```
   Device token obtained: fG_X-V3qY-m2eR5k9_4sLpA6o7j8n9_0_z_1_h_2_i_3_j_4_k_5_l_6_m_7_n_8_o_9_p_0
   Platform: android
   ```
3. **Verify API call** di server logs untuk memastikan device token terkirim

### 2. Test Foreground Notifications

1. **Buka app** dan pastikan di foreground
2. **Buka Firebase Console** → Cloud Messaging
3. **Create test message**:
   - Title: "Test Notification"
   - Body: "This is a test message"
   - Target: Device token (copy dari console log)
4. **Send message**
5. **Verify** in-app notification muncul di atas screen

### 3. Test Background Notifications

1. **Minimize app** (jangan close completely)
2. **Send test notification** dari Firebase Console
3. **Verify** system notification muncul di notification panel
4. **Tap notification** dan verify app terbuka

### 4. Test Terminated State Notifications

1. **Close app completely** (swipe up dan close)
2. **Send test notification** dari Firebase Console
3. **Verify** system notification muncul
4. **Tap notification** dan verify app terbuka

### 5. Test Navigation with Data Payload

1. **Send notification** dengan data payload:
   ```json
   {
     "notification": {
       "title": "Navigate Test",
       "body": "Tap to navigate"
     },
     "data": {
       "route": "/home",
       "action": "show_qr"
     }
   }
   ```
2. **Tap notification** dan verify navigation berfungsi

### 6. Test Topic Subscription

1. **Subscribe to topic**:
   ```dart
   await FirebaseMessagingService().subscribeToTopic('general');
   ```
2. **Send notification** ke topic 'general'
3. **Verify** notification diterima

## Firebase Console Configuration

### 1. Create Notification Channel (Android)

1. Buka **Firebase Console** → Project Settings
2. Go to **Cloud Messaging** tab
3. Create notification channel:
   - Channel ID: `srigunting_notifications`
   - Channel Name: `Srigunting Notifications`
   - Description: `Main notification channel for Srigunting app`
   - Importance: High
   - Sound: Default

### 2. Test Message Format

#### Basic Test Message

```json
{
  "notification": {
    "title": "Test Title",
    "body": "Test Body"
  }
}
```

#### Advanced Test Message

```json
{
  "notification": {
    "title": "Promotion Alert!",
    "body": "Check out our latest offers",
    "image": "https://example.com/promotion.jpg"
  },
  "data": {
    "route": "/promotions",
    "promotion_id": "123",
    "action": "view_promotion"
  }
}
```

### 3. Targeting Options

#### By Device Token

- Copy device token dari console log
- Paste di "Send to" field
- Send message

#### By Topic

- Subscribe device ke topic tertentu
- Send message ke topic
- All subscribed devices akan menerima

#### By Condition

- Use FCM condition syntax
- Example: `'general' in topics && 'android' in topics`

## Troubleshooting

### Common Issues

#### 1. Token Not Generated

**Symptoms**: Console log shows "Failed to get device token"

**Solutions**:

- Check Firebase configuration files
- Verify Google Services plugin
- Check device internet connection
- Restart app

#### 2. Notifications Not Received

**Symptoms**: No notification appears

**Solutions**:

- Check notification permissions
- Verify notification channel (Android)
- Check background app refresh (iOS)
- Test with different device

#### 3. In-App Notification Not Showing

**Symptoms**: System notification works but in-app doesn't

**Solutions**:

- Check Flushbar dependencies
- Verify context availability
- Check debug logs for errors

#### 4. Navigation Not Working

**Symptoms**: Notification opens app but doesn't navigate

**Solutions**:

- Check route names
- Verify navigation context
- Check data payload format
- Add debug logs

### Debug Commands

#### Enable Debug Logging

```dart
// Di FirebaseMessagingService
if (kDebugMode) {
  print('FCM Token: $token');
  print('Message received: ${message.notification?.title}');
  print('Navigation data: ${message.data}');
}
```

#### Check Permissions

```dart
// Check notification permissions
NotificationSettings settings = await FirebaseMessaging.instance.getNotificationSettings();
print('Permission status: ${settings.authorizationStatus}');
```

#### Verify Token

```dart
// Get and verify token
String? token = await FirebaseMessaging.instance.getToken();
print('Current token: $token');
```

## Performance Testing

### 1. Load Testing

- Send multiple notifications rapidly
- Verify app performance
- Check memory usage

### 2. Battery Testing

- Monitor battery usage
- Test background processing
- Check wake lock behavior

### 3. Network Testing

- Test with poor connectivity
- Verify offline behavior
- Check retry mechanisms

## Security Testing

### 1. Payload Validation

- Test with malformed data
- Verify error handling
- Check data sanitization

### 2. Permission Testing

- Test with denied permissions
- Verify graceful degradation
- Check fallback behavior

### 3. Token Security

- Verify token uniqueness
- Check token refresh
- Test token invalidation

## Production Checklist

### Before Release

- [ ] All notification types tested
- [ ] Error handling verified
- [ ] Performance optimized
- [ ] Security reviewed
- [ ] Documentation updated
- [ ] Team trained

### Monitoring

- [ ] Analytics implemented
- [ ] Error tracking enabled
- [ ] Performance monitoring
- [ ] User feedback collection

## Support

### Logs to Collect

1. Device token
2. Platform information
3. Permission status
4. Error messages
5. Network status

### Contact Information

- Development Team: [Your Team]
- Firebase Support: [Firebase Console]
- Documentation: [Your Docs]

## Additional Resources

- [Firebase Cloud Messaging Documentation](https://firebase.google.com/docs/cloud-messaging)
- [Flutter Firebase Messaging Plugin](https://pub.dev/packages/firebase_messaging)
- [Android Notification Best Practices](https://developer.android.com/guide/topics/ui/notifiers/notifications)
- [iOS Push Notifications Guide](https://developer.apple.com/documentation/usernotifications)
