import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sws_assessment/app.dart';
import 'package:sws_assessment/application/auth_controller.dart';
import 'package:sws_assessment/data/remote/news_repo_impl.dart';
import 'package:sws_assessment/domain/repositories/news_repository.dart';
import 'package:sws_assessment/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initDependencies();
  runApp(const MyApp());
}

void initDependencies() {
  Get.lazyPut<AuthController>(()=> AuthController());
  Get.put<NewsRepository>(NewsRepoImpl());
}
