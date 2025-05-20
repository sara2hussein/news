import 'package:flutter/material.dart';
import 'package:news/Ui/widget/drawer_item.dart';
import 'package:news/Ui/widget/lang_buttom_sheet.dart';
import 'package:news/provider/theme_provider.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';
import 'package:news/utils/assets_manager.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        bool isDark = themeProvider.isDarkMode();

        return Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: height * 0.25,
              color: AppColors.whiteColor,
              child: Text('News App', style: AppStyles.bold24Black),
            ),
            SizedBox(height: height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              child: Row(
                children: [
                  Image.asset(AssetsManager.home_icon),

                  TextButton(
                    child: Text('Go To Home', style: AppStyles.bold20White),
                    onPressed: () {
                      //func go home
                    },
                  ),
                ],
              ),
            ),
            // SizedBox(height: height * 0.01),
            Divider(
              color: AppColors.whiteColor,
              indent: width * 0.04,
              endIndent: width * 0.04,
            ),
            SizedBox(height: height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              child: DrawerItem(image: AssetsManager.theme_icon, text: 'Theme'),
            ),
            SizedBox(height: height * 0.01),
            LangButtomSheet(
              text: isDark ? 'Dark' : 'Light',
              onTap: () {
                ThemeMode newTheme = isDark ? ThemeMode.light : ThemeMode.dark;
                themeProvider.changeTheme(newTheme);
              },
            ),
            SizedBox(height: height * 0.01),
            Divider(
              color: AppColors.whiteColor,
              indent: width * 0.04,
              endIndent: width * 0.04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              child: DrawerItem(
                image: AssetsManager.lang_icon,
                text: 'Language',
              ),
            ),
            SizedBox(height: height * 0.01),
            LangButtomSheet(text: 'English'),
          ],
        );
      },
    );
  }
}
