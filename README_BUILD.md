# Build APK Guide

## Script Build APK

File `build_apk.sh` sudah dibuat untuk memudahkan build APK dengan environment yang berbeda.

### Cara Penggunaan

1. **Build untuk Staging (default)**

   ```bash
   ./build_apk.sh
   ```

   atau

   ```bash
   ./build_apk.sh staging
   ```

2. **Build untuk Production**
   ```bash
   ./build_apk.sh production
   ```

### Environment Configuration

- **Staging**: `https://stagingcrm.balibirdpark.com`
- **Production**: `https://crm.balibirdpark.com`

### Output

APK akan tersimpan di: `build/app/outputs/flutter-apk/app-release.apk`

## Manual Build

Jika ingin build manual tanpa script:

```bash
# Staging
flutter build apk --release --dart-define=API_URL=https://stagingcrm.balibirdpark.com

# Production
flutter build apk --release --dart-define=API_URL=https://crm.balibirdpark.com
```

## Troubleshooting

### Error Login setelah Install APK

Error `NoSuchMethodError: The method '[]' was called on null` sudah diperbaiki dengan:

1. **Perbaikan responseHandler**: Menambahkan null safety untuk `errorBody`
2. **Perbaikan parameter onError**: Mengubah dari `errorBody` menjadi `errorMessage`
3. **Update semua BLoC**: Menggunakan parameter yang benar

### Pastikan Build dengan Environment yang Benar

- Gunakan script `build_apk.sh` untuk memastikan API_URL ter-set dengan benar
- Atau gunakan `--dart-define=API_URL=...` saat build manual
