# Device Token Implementation

## Overview

Implementasi API untuk mengirim device token dan platform ke server ketika home screen pertama kali dibuka untuk kebutuhan Firebase notification. Device token dikirim secara terintegrasi dengan API calls lainnya dalam urutan yang rapi menggunakan `Future.wait`.

## API Endpoint

- **URL**: `/api/device-token`
- **Method**: `PATCH`
- **Parameters**:
  ```json
  {
    "device_token": "fG_X-V3qY-m2eR5k9_4sLpA6o7j8n9_0_z_1_h_2_i_3_j_4_k_5_l_6_m_7_n_8_o_9_p_0",
    "platform": "android"
  }
  ```

## Files Modified

### 1. Repository Layer

- **`lib/src/repository/auth_repository.dart`**: Menambahkan method `updateDeviceToken`
- **`lib/src/repository/rest/auth_rest_repository.dart`**: Implementasi method `updateDeviceToken`
- **`lib/src/repository/api_url/api_url.dart`**: Menambahkan endpoint `DEVICE_TOKEN`

### 2. BLoC Layer

- **`lib/src/ui/app/home/bloc/home_event.dart`**:
  - Menambahkan parameter `deviceToken` dan `platform` ke `HomeInitialExecute`
- **`lib/src/ui/app/home/bloc/home_bloc.dart`**:
  - Mengintegrasikan API device token ke dalam `Future.wait`
  - Menambahkan response handler untuk device token API
  - Semua API calls berjalan secara async dengan urutan yang rapi

### 3. UI Layer

- **`lib/src/ui/app/home/home_screen.dart`**:
  - Menambahkan logika untuk mendapatkan device token dan platform
  - Mengirim device token dan platform ke HomeBloc melalui event
  - Firebase initialization dan permission handling

### 4. Dependency Injection

- **`lib/src/android.dart`**: Menambahkan `AuthRepository` ke resolvers `HomeBloc`
- **`lib/src/ios.dart`**: Menambahkan `AuthRepository` ke resolvers `HomeBloc`

### 5. Dependencies

- **`pubspec.yaml`**: Menambahkan `firebase_messaging` dan `firebase_core`

### 6. Firebase Configuration

- **`lib/firebase_options.dart`**: File konfigurasi Firebase (perlu diisi dengan konfigurasi yang benar)

## How It Works

1. **Initialization**: Ketika `HomeScreen` dibuka, method `_initializeAndSendDeviceToken()` dipanggil
2. **Firebase Setup**: Firebase diinisialisasi dengan konfigurasi platform yang sesuai
3. **Permission Request**: Meminta permission untuk notification dari user
4. **Token Retrieval**: Mendapatkan device token dari Firebase Messaging
5. **Platform Detection**: Mendeteksi platform (Android/iOS) menggunakan `Platform.isAndroid`
6. **Event Dispatch**: Mengirim event `HomeInitialExecute` dengan device token dan platform
7. **API Integration**: Device token API terintegrasi dengan API calls lainnya dalam `Future.wait`
8. **Response Handling**: Semua API responses dihandle secara berurutan dan rapi

## API Calls Order

Semua API calls berjalan secara async dengan urutan yang rapi:

```dart
List<Future> apiCalls = [
  _guideRepository.detailAccountSrigunting(),           // Index 0
  _balanceRepopsitory.showBalance(),                    // Index 1
  _rewardRepository.showPointReward(),                  // Index 2
  _informationRepository.fetchInformation(...),         // Index 3
  _notificationRepository.fetchNotification(...),       // Index 4
  _authRepository.updateDeviceToken(...),               // Index 5 (if available)
];
```

## Firebase Setup Required

Untuk menggunakan fitur ini, Anda perlu:

1. **Setup Firebase Project**:

   - Buat project di [Firebase Console](https://console.firebase.google.com/)
   - Tambahkan aplikasi Android dan iOS
   - Download file konfigurasi

2. **Update `firebase_options.dart`**:

   - Ganti placeholder values dengan konfigurasi Firebase yang sebenarnya
   - Untuk Android: `google-services.json`
   - Untuk iOS: `GoogleService-Info.plist`

3. **Android Setup**:

   - Tambahkan `google-services.json` ke `android/app/`
   - Update `android/app/build.gradle` dengan plugin Google Services

4. **iOS Setup**:
   - Tambahkan `GoogleService-Info.plist` ke `ios/Runner/`
   - Update `ios/Runner/Info.plist` dengan konfigurasi yang diperlukan

## Testing

1. **Run the app** dan buka home screen
2. **Check logs** untuk melihat:
   - "Device token updated successfully" (success)
   - "Device token update failed: [error]" (error)
3. **Verify API call** di server logs untuk memastikan device token terkirim
4. **Check loading behavior** - semua API calls berjalan secara async dengan urutan yang rapi

## Error Handling

- Jika Firebase gagal diinisialisasi, error akan di-catch dan di-print ke console
- Jika permission ditolak, device token tidak akan dikirim (API call tidak ditambahkan ke Future.wait)
- Jika API call gagal, error akan di-log tanpa menampilkan toast ke user
- Semua error handling dilakukan secara silent untuk tidak mengganggu user experience

## Key Benefits

- **Ordered Async Execution**: Semua API calls berjalan dengan urutan yang rapi menggunakan `Future.wait`
- **Integrated Flow**: Device token API terintegrasi dengan API calls utama
- **No Race Conditions**: Tidak ada masalah async karena semua API calls dihandle dalam satu `Future.wait`
- **Clean Architecture**: Mengikuti pattern yang sudah ada di project
- **Silent Operation**: Tidak mengganggu user experience dengan loading atau error messages

## Notes

- Device token akan dikirim setiap kali home screen dibuka
- Implementasi ini mengikuti pattern yang sudah ada di project (BLoC, Repository, DI)
- Menggunakan internal UI components sesuai dengan workspace rules
- Mengikuti naming convention yang sudah ada (kebab_case, PascalCase)
- Semua API calls berjalan secara async dengan urutan yang rapi dan terstruktur
