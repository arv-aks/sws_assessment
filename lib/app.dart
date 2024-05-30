import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sws_assessment/presentation/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(useMaterial3: false),
      home: const SplashPage(),
    );
  }
}
