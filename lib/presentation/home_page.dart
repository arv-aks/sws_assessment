import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sws_assessment/application/auth_controller.dart';
import 'package:sws_assessment/application/home_controller.dart';
import 'package:sws_assessment/domain/repositories/news_repository.dart';
import 'package:sws_assessment/presentation/widgets/custom_loading.dart';
import 'package:sws_assessment/presentation/widgets/news_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
  
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text("Home"),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () async {
                await authController
                    .logout()
                    .then((value) => Get.snackbar("Logout", "Successful"));
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: GetX(
          init: HomeController(newsRepository: Get.find<NewsRepository>()),
          builder: (controller) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: controller.isLoading.value
                    ? const CustomLoading()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                          itemCount: controller.newsList.length,
                          itemBuilder: (context, index) {
                            return NewsCard(news: controller.newsList[index]);
                          },
                        ),
                      ),
              ),
            );
          },
        ));
  }
}
