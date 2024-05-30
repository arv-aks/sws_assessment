import 'package:fpdart/fpdart.dart';
import 'package:sws_assessment/data/models/news_model.dart';

abstract class NewsRepository {
  //we can replace the "String" to our "Network Expections Type"
  //later we can handle state based on Exception
  Future<Either<String, List<NewsModel>>> getNews();
}
