import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:srigunting_app/src/infrastructure/navigation/nav_key.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';

/// Service untuk menangani Firebase Messaging dan push notifications
class FirebaseMessagingService {
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();
  factory FirebaseMessagingService() => _instance;
  FirebaseMessagingService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Initialize Firebase Messaging
  Future<void> initialize() async {
    try {
      // Request permission untuk notifications
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (kDebugMode) {
        print(
            'Firebase Messaging permission status: ${settings.authorizationStatus}');
      }

      // Setup message handlers
      _setupMessageHandlers();

      // Get FCM token
      String? token = await _messaging.getToken();
      if (kDebugMode) {
        print('FCM Token: $token');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing Firebase Messaging: $e');
      }
    }
  }

  /// Setup message handlers untuk foreground dan background
  void _setupMessageHandlers() {
    // Handler untuk pesan yang diterima saat app di foreground
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handler untuk pesan yang diterima saat app di background tapi masih hidup
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Handler untuk pesan yang diterima saat app dibuka dari terminated state
    _messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleMessageOpenedApp(message);
      }
    });
  }

  /// Handle pesan yang diterima saat app di foreground
  void _handleForegroundMessage(RemoteMessage message) {
    if (kDebugMode) {
      print('Received foreground message: ${message.messageId}');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Data: ${message.data}');
    }

    // Tampilkan in-app notification atau snackbar
    _showInAppNotification(message);
  }

  /// Handle pesan yang membuka app
  void _handleMessageOpenedApp(RemoteMessage message) {
    if (kDebugMode) {
      print('Message opened app: ${message.messageId}');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Data: ${message.data}');
    }

    // Handle navigation berdasarkan data yang dikirim
    _handleNotificationNavigation(message);
  }

  /// Tampilkan in-app notification
  void _showInAppNotification(RemoteMessage message) {
    // Get current context dari global navigator key
    final context = NavigationService.instance.navigatorKey.currentContext;

    if (context != null && context.mounted) {
      Flushbar(
        title: message.notification?.title ?? 'Notification',
        message: message.notification?.body ?? '',
        duration: const Duration(seconds: 4),
        backgroundColor: AppColors.bgBasePrimary,
        titleColor: AppColors.textBasePrimary,
        messageColor: AppColors.textBaseSecondary,
        icon: const Icon(
          Icons.notifications,
          color: AppColors.iconBrandPrimary,
        ),
        margin: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
        onTap: (flushbar) {
          flushbar.dismiss();
          _handleNotificationNavigation(message);
        },
      ).show(context);
    } else {
      if (kDebugMode) {
        print('Cannot show notification: context is null or not mounted');
      }
    }
  }

  /// Handle navigation berdasarkan data notifikasi
  void _handleNotificationNavigation(RemoteMessage message) {
    final data = message.data;

    if (kDebugMode) {
      print('Notification data received: $data');
    }

    // Extract route dan slug dari data notification
    String? route = data['route'];
    String? slug = data['slug'];

    if (route != null && route.isNotEmpty) {
      // Navigate ke route yang ditentukan dengan slug jika ada
      _navigateToRoute(route, slug);
    } else {
      // Default navigation ke app home jika tidak ada route
      _navigateToRoute(Routing.APP, null);
    }

    if (data.containsKey('action')) {
      // Handle action yang ditentukan
      final action = data['action'];
      if (kDebugMode) {
        print('Handle action: $action');
      }
      // TODO: Implement action handling
    }
  }

  /// Navigate ke route tertentu dengan optional slug parameter
  void _navigateToRoute(String route, String? slug) {
    final context = NavigationService.instance.navigatorKey.currentContext;

    if (context == null || !context.mounted) {
      if (kDebugMode) {
        print('Cannot navigate: context is null or not mounted');
      }
      return;
    }

    try {
      // Build route arguments map
      Map<String, String>? arguments;
      if (slug != null && slug.isNotEmpty) {
        arguments = {'slug': slug};
      }

      if (kDebugMode) {
        print('Navigating to route: $route');
        if (arguments != null) {
          print('With arguments: $arguments');
        }
      }

      // Navigate menggunakan Navigator
      Navigator.pushNamed(
        context,
        route,
        arguments: arguments,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error navigating to route $route: $e');
      }
      // Fallback navigation ke app home
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routing.APP,
        (route) => false,
      );
    }
  }

  /// Get FCM token
  Future<String?> getToken() async {
    try {
      print('FirebaseMessagingService: Getting token...');
      String? token = await _messaging.getToken();
      print(
          'FirebaseMessagingService: Token retrieved: ${token != null ? 'Success' : 'Null'}');
      if (token != null) {
        print('FirebaseMessagingService: Token value: $token');
      }
      return token;
    } catch (e) {
      print('FirebaseMessagingService: Error getting FCM token: $e');
      print('FirebaseMessagingService: Error details: ${e.toString()}');
      return null;
    }
  }

  /// Subscribe ke topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      if (kDebugMode) {
        print('Subscribed to topic: $topic');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error subscribing to topic $topic: $e');
      }
    }
  }

  /// Unsubscribe dari topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      if (kDebugMode) {
        print('Unsubscribed from topic: $topic');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error unsubscribing from topic $topic: $e');
      }
    }
  }

  /// Get platform info
  String getPlatform() {
    if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    }
    return 'unknown';
  }

  /// Check if Firebase Messaging is properly initialized
  Future<bool> isInitialized() async {
    try {
      print('FirebaseMessagingService: Checking initialization...');
      // Try to get token to check if messaging is working
      String? token = await _messaging.getToken();
      print(
          'FirebaseMessagingService: Token result: ${token != null ? "Success" : "Null"}');
      return token != null;
    } catch (e) {
      print('FirebaseMessagingService: Initialization check failed: $e');
      return false;
    }
  }
}

/// Background message handler
/// Fungsi ini harus berada di top level (bukan di dalam class)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('Handling background message: ${message.messageId}');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');
  }

  final data = message.data;

  // Extract route dan slug untuk debugging
  if (data.containsKey('route')) {
    final route = data['route'];
    final slug = data['slug'];
    if (kDebugMode) {
      print('Background message route: $route');
      if (slug != null) {
        print('Background message slug: $slug');
      }
    }
  }

  // TODO: Handle background message processing
  // Misalnya: update local database, show local notification, dll
  // Data route dan slug sudah tersedia di message.data untuk digunakan saat app dibuka
}
