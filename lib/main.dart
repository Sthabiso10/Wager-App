import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wager_app/app/constants/strings.dart';
import 'package:wager_app/firebase_options.dart';
import 'package:wager_app/locator.dart';
import 'package:wager_app/services/route_service.dart';
import 'package:wager_app/styles/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  setupLocator(); // Setup service locator AFTER bindings

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: appTheme(textTheme: textTheme),
      initialRoute: RouteService.authPage,
      onGenerateRoute: RouteService.getRoute,
    );
  }
}
