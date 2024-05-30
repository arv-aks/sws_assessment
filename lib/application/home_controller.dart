// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:sws_assessment/data/models/news_model.dart';

import 'package:sws_assessment/domain/repositories/news_repository.dart';

class HomeController extends GetxController {
  final NewsRepository newsRepository;
  HomeController({
    required this.newsRepository,
  });

  RxList<NewsModel> newsList = <NewsModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getAllNews();
  }

  Future<void> getAllNews() async {
    isLoading.value = true;
    final result = await newsRepository.getNews();
    result.fold((l) => Get.snackbar("Error", l), (r) {
      newsList.addAll(r);
    });
    isLoading.value = false;
  }
}
