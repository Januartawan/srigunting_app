import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:srigunting_app/cmd/app.dart';
import 'package:srigunting_app/firebase_options.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/frame/frame.dart';
import 'package:srigunting_app/src/infrastructure/navigation/nav_key.dart';
import 'package:srigunting_app/src/infrastructure/services/firebase_messaging_service.dart';
import 'package:srigunting_app/src/infrastructure/theme/srigunting_theme.dart';
import 'package:srigunting_app/env.dart' as env;
import 'package:srigunting_app/src/ios.dart';

void main() async {
  if (env.appFlavor == "dev") {
    if (kDebugMode) {
      print('Starting iOS app initialization...');
    }
    IosModule.setup();
    WidgetsFlutterBinding.ensureInitialized();
    if (kDebugMode) {
      print('WidgetsFlutterBinding initialized');
      // Initialize Firebase
      print('Initializing Firebase...');
    }

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (kDebugMode) {
      print('Firebase initialized successfully');
      // Set background message handler
      print('Setting background message handler...');
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    if (kDebugMode) {
      print('Background message handler set');
      // Initialize Firebase Messaging Service
      print('Initializing Firebase Messaging Service...');
    }

    await FirebaseMessagingService().initialize();
    if (kDebugMode) {
      print('Firebase Messaging Service initialized');
      print('iOS app initialization complete');
    }

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    runApp(IOS(
      isLoggedIn: false,
    ));
  }
}

class IOS extends App {
  final bool isLoggedIn;

  IOS({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Srigunting',
      theme: SriguntingTheme(context).sriguntingThemeDefault,
      home: const Frame(),
    );
  }
}
