# Push Notification Navigation Guide

## Overview
Panduan ini menjelaskan cara menangani navigasi dari push notification dengan data `route` dan `slug` pada aplikasi Srigunting.

## Payload Structure
Push notification harus mengirim data dalam format berikut:

```json
{
  "device_token": "FCM_DEVICE_TOKEN",
  "title": "Judul Notifikasi",
  "body": "Isi notifikasi",
  "route": "/information",
  "slug": "undian-july-2025"
}
```

## Available Routes
Berikut adalah route yang tersedia untuk navigasi dari push notification:

- `/information` - Detail informasi (memerlukan `slug`)
- `/informations` - List informasi
- `/reward-and-point` - Halaman reward dan point
- `/reward-and-point/detail` - Detail reward dan point
- `/free-ticket` - Halaman free ticket
- `/free-ticket/detail` - Detail free ticket (memerlukan `slug`)
- `/redeem-point` - Halaman redeem point
- `/profile` - Halaman profil
- `/notification` - Halaman notifikasi
- `/app` - Halaman utama (default fallback)

## How It Works

### 1. Data Extraction
Ketika notifikasi diterima, system akan mengekstrak:
- `route` dari `message.data['route']`
- `slug` dari `message.data['slug']`

### 2. Navigation Flow
- **Foreground**: Notifikasi muncul sebagai Flushbar, jika di-tap akan navigasi
- **Background/Terminated**: Ketika app dibuka dari notifikasi akan langsung navigasi
- **Fallback**: Jika tidak ada `route`, akan navigasi ke `/app`

### 3. Implementation Details
- `_handleNotificationNavigation()` - Main handler untuk navigation
- `_navigateToRoute()` - Method untuk execute navigation dengan arguments
- Support untuk routes yang memerlukan `slug` parameter

## Example Usage

### Information Detail
```json
{
  "title": "Undian Berhadian Oktober 2025!",
  "body": "Datang dan saksikan pengundiannya, siapa tau nama kamu yang muncul",
  "route": "/information",
  "slug": "undian-july-2025"
}
```

### Simple Navigation (no slug required)
```json
{
  "title": "Reward Baru Tersedia!",
  "body": "Cek reward terbaru yang bisa kamu tukar",
  "route": "/reward-and-point"
}
```

## Debugging
Enable debug mode untuk melihat log:
- `Notification data received: {route: /information, slug: undian-july-2025}`
- `Navigating to route: /information`
- `With arguments: {slug: undian-july-2025}`

## Testing
Untuk testing push notification dengan navigation, gunakan Firebase Console atau API dengan payload yang sesuai format di atas.