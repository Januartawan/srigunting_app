import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:srigunting_app/src/infrastructure/navigation/nav_key.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
class FirebaseMessagingService {
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();
  factory FirebaseMessagingService() => _instance;
  FirebaseMessagingService._internal();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  Future<void> initialize() async {
    try {
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
        print('Firebase Messaging permission status: ${settings.authorizationStatus}');
      }
      _setupMessageHandlers();
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
  void _setupMessageHandlers() {
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
    _messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleMessageOpenedApp(message);
      }
    });
  }
  void _handleForegroundMessage(RemoteMessage message) {
    if (kDebugMode) {
      print('Received foreground message: ${message.messageId}');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Data: ${message.data}');
    }
    _showInAppNotification(message);
  }
  void _handleMessageOpenedApp(RemoteMessage message) {
    if (kDebugMode) {
      print('Message opened app: ${message.messageId}');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Data: ${message.data}');
    }
    _handleNotificationNavigation(message);
  }
  void _showInAppNotification(RemoteMessage message) {
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
  void _handleNotificationNavigation(RemoteMessage message) {
    final data = message.data;
    if (kDebugMode) {
      print('Notification data received: $data');
    }
    String? route = data['route'];
    String? slug = data['slug'];
    if (route != null && route.isNotEmpty) {
      _navigateToRoute(route, slug);
    } else {
      _navigateToRoute(Routing.APP, null);
    }
    if (data.containsKey('action')) {
      final action = data['action'];
      if (kDebugMode) {
        print('Handle action: $action');
      }
    }
  }
  void _navigateToRoute(String route, String? slug) {
    final context = NavigationService.instance.navigatorKey.currentContext;
    if (context == null || !context.mounted) {
      if (kDebugMode) {
        print('Cannot navigate: context is null or not mounted');
      }
      return;
    }
    try {
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
      Navigator.pushNamed(
        context,
        route,
        arguments: arguments,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error navigating to route $route: $e');
      }
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routing.APP,
        (route) => false,
      );
    }
  }
  Future<String?> getToken() async {
    try {
      if (kDebugMode) {
        print('FirebaseMessagingService: Getting token...');
      }
      String? token = await _messaging.getToken();
      if (kDebugMode) {
        print('FirebaseMessagingService: Token retrieved: ${token != null ? 'Success' : 'Null'}');
      }
      if (token != null) {
        if (kDebugMode) {
          print('FirebaseMessagingService: Token value: $token');
        }
      }
      return token;
    } catch (e) {
      if (kDebugMode) {
        print('FirebaseMessagingService: Error getting FCM token: $e');
        print('FirebaseMessagingService: Error details: ${e.toString()}');
      }
      return null;
    }
  }
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
  String getPlatform() {
    if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    }
    return 'unknown';
  }
  Future<bool> isInitialized() async {
    try {
      if (kDebugMode) {
        print('FirebaseMessagingService: Checking initialization...');
      }
      String? token = await _messaging.getToken();
      if (kDebugMode) {
        print('FirebaseMessagingService: Token result: ${token != null ? "Success" : "Null"}');
      }
      return token != null;
    } catch (e) {
      if (kDebugMode) {
        print('FirebaseMessagingService: Initialization check failed: $e');
      }
      return false;
    }
  }
}
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('Handling background message: ${message.messageId}');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');
  }
  final data = message.data;
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
}
