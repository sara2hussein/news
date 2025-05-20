import 'package:flutter/material.dart';
import 'package:news/models/category.dart';
import 'package:news/provider/theme_provider.dart';
import 'package:news/utils/app_colors.dart';
import 'package:provider/provider.dart';

class CategoryFragment extends StatelessWidget {
  List<Category> categoriesList = [];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode();
    categoriesList = Category.getCategoriesList(isDark);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Good Morning \n Here is Some News For You',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: height * 0.02),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: height * 0.02);
              },
              itemBuilder: (context, index) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Stack(
                    alignment:
                        (index % 2 == 0)
                            ? Alignment.bottomRight
                            : Alignment.bottomLeft,
                    children: [
                      Image.asset(categoriesList[index].image),
                      Container(
                        padding: EdgeInsets.only(left: width * 0.02),
                        margin: EdgeInsets.symmetric(
                          horizontal: width * 0.02,
                          vertical: height * 0.02,
                        ),
                        width: width * 0.38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(64),
                          color: AppColors.greyColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'View All',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),

                            CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              child: IconButton(
                                onPressed: () {
                                  //function
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Theme.of(context).indicatorColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: categoriesList.length,
            ),
          ),
        ],
      ),
    );
  }
}
