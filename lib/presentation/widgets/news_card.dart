
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sws_assessment/data/models/news_model.dart';
import 'package:sws_assessment/presentation/widgets/custom_loading.dart';
import 'package:sws_assessment/utils/utils.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.news,
  });

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      news.description.toString(),
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      Utils.getRelativeTime(news.publishedAt.toString()),
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SizedBox(
                  height: 120,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: news.urlToImage,
                      progressIndicatorBuilder: (context, url, progress) {
                        return const CustomLoading();
                      },
                      errorWidget: (context, url, error) {
                       return const Icon(Icons.error_outline_sharp, size: 60);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
