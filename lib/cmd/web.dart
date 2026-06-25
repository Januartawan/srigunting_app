import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:srigunting_app/cmd/app.dart';
import 'package:srigunting_app/firebase_options.dart';
import 'package:srigunting_app/src/infrastructure/navigation/nav_key.dart';
import 'package:srigunting_app/src/infrastructure/services/firebase_messaging_service.dart';
import 'package:srigunting_app/src/infrastructure/theme/srigunting_theme.dart';
import 'package:srigunting_app/src/routing/router.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';

void main() async {
  print('Starting Web app initialization...');
  WidgetsFlutterBinding.ensureInitialized();
  print('WidgetsFlutterBinding initialized');

  // Initialize Firebase
  print('Initializing Firebase...');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Firebase initialized successfully');

  // Set background message handler
  print('Setting background message handler...');
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  print('Background message handler set');

  // Initialize Firebase Messaging Service
  print('Initializing Firebase Messaging Service...');
  await FirebaseMessagingService().initialize();
  print('Firebase Messaging Service initialized');

  print('Web app initialization complete');
  runApp(WEB());
}

class WEB extends App {
  WEB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RoutingApp.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Srigunting',
      theme: SriguntingTheme(context).sriguntingThemeDefault,
      initialRoute: Routing.INITIAL_LOADING,
    );
  }
}
