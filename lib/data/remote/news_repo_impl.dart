import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sws_assessment/data/core/constants.dart';
import 'package:sws_assessment/data/models/news_model.dart';
import 'package:sws_assessment/domain/api_provider/api_provider.dart';
import 'package:sws_assessment/domain/repositories/news_repository.dart';

class NewsRepoImpl implements NewsRepository {
  final Dio _dio;

  NewsRepoImpl() : _dio = ApiProvider.getDio();

  @override
  Future<Either<String, List<NewsModel>>> getNews() async {
    List<NewsModel> newsList = [];

//picking up random api key
    final random = Random();
    final newsApiKey =
        Constants.apiKeys[random.nextInt(Constants.apiKeys.length)];

    final url =
        "${Constants.topHeadlineUrl}?country=IN&pageSize=100&page=1&apiKey=$newsApiKey";

    try {
      final result = await _dio.get(url);
      final List<dynamic> articlesList = result.data['articles'];
      newsList = articlesList.map((map) => NewsModel.fromJson(map)).toList();

      //removing empty data
      newsList.removeWhere((element) {
        return element.description.isEmpty ||
            element.description == "[Removed]";
      });
    } catch (e) {
      return left("$e");
    }

    return right(newsList);
  }
}
