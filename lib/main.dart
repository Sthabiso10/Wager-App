import 'package:flutter/material.dart';
import 'package:wager_app/app/constants/strings.dart';
import 'package:wager_app/services/route_service.dart';
import 'package:wager_app/styles/theme.dart';

void main() {
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
      initialRoute: RouteService.navigationMenu,
      onGenerateRoute: RouteService.getRoute,
    );
  }
}
