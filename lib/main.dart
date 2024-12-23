  import 'package:flutter/material.dart';
  import 'routes/routes.dart';

  void main() {
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'B12 Petshop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // Set the initial route to home
        initialRoute: AppRoutes.home,
        // Use the centralized routes from routes.dart
        routes: AppRoutes.routes,
      );
    }
  }
