import 'package:flutter/material.dart';
import 'package:news/Ui/home/category_details/source_tap_widget.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/models/SourceResponse.dart';
import 'package:news/models/category.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';

class CategoryDetails extends StatefulWidget {
  final Category category;
  final bool isSearchVisible;

  CategoryDetails({required this.category, required this.isSearchVisible});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse?>(
      future: ApiManager.getSources(widget.category.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.greyColor),
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Text('Something went Wrong', style: AppStyles.meduim20Black),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text(
                  'Try Again',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ],
          );
        }

        if (snapshot.data?.status != 'ok') {
          return Column(
            children: [
              Text(
                snapshot.data!.message!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text('Try Again', style: AppStyles.meduim20Black),
              ),
            ],
          );
        }

        var sourcesList = snapshot.data?.sourcesList ?? [];
        return SourceTapWidget(sourcesList: sourcesList, isSearchVisible: widget.isSearchVisible);
      },
    );
  }
}