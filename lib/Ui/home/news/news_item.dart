import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/models/NewsResponse.dart';
import 'package:news/utils/app_colors.dart';
import 'package:timeago/timeago.dart' as timeago;


class NewsItem extends StatelessWidget {
  News news;
  NewsItem({required this.news});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).indicatorColor, width: 2),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: news.urlToImage ?? '',
              placeholder:
                  (context, url) => const CircularProgressIndicator(
                    color: AppColors.greyColor,
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          SizedBox(height: height * 0.02),
          Text(news.title ?? '', style: Theme.of(context).textTheme.labelLarge),
          SizedBox(height: height * 0.02),

          Row(
            children: [
              Expanded(
                child: Text(
                  'By: ${news.author ?? ''}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              Text(
  timeago.format(DateTime.tryParse(news.publishedAt ?? '') ?? DateTime.now()),
  style: Theme.of(context).textTheme.labelSmall,
),
            ],
          ),
        ],
      ),
    );
  }
}
