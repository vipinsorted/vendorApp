import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';
import 'package:vendor_app/routes/app_routes.dart';
import 'package:vendor_app/screens/splash_screen/screen/new_splash_screen.dart';

import 'network/api_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await ApiClient.init();
    // Only call clearSavedSettings() during testing to reset internal values.
    // await Upgrader.clearSavedSettings();
    // REMOVE this for release builds
    // On Android, the default behavior will be to use the Google Play Store
    // version of the app.
    // On iOS, the default behavior will be to use the App Store version of
    // the app, so update the Bundle Identifier in example/ios/Runner with a
    // valid identifier already in the App Store.
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: AppRoutes.routes,
      home: const NewSplashScreen(),
    );
  }
}