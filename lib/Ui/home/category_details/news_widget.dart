import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/models/NewsResponse.dart';
import 'package:news/models/SourceResponse.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';

class NewsWidget extends StatelessWidget {
  Sources source;
  NewsWidget({required this.source});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponse?>(
      future: ApiManager.getNewsBySourceId(source.id ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.greyColor),
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Text('Something went Wrong', style: AppStyles.meduim20Black),
              ElevatedButton(
                onPressed: () {
                  ApiManager.getNewsBySourceId(source.id ?? '');
                  //setState(() {});
                },
                child: Text('Try Again', style: AppStyles.meduim20Black),
              ),
            ],
          );
        }
        if (snapshot.data?.status != 'ok') {
          return Column(
            children: [
              Text(snapshot.data!.message!, style: AppStyles.meduim20Black),
              ElevatedButton(
                onPressed: () {
                  ApiManager.getNewsBySourceId(source.id ?? '');
                  //setState(() {});
                },
                child: Text('Try Again', style: AppStyles.meduim20Black),
              ),
            ],
          );
        }
      },
    );
  }
}
