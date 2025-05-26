import 'package:flutter/material.dart';
import 'package:news/Ui/home/home_screen.dart';
import 'package:news/Ui/widget/view_article.dart';
import 'package:news/provider/theme_provider.dart';
import 'package:news/utils/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => ThemeProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        ViewArticle.routeName: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return ViewArticle(articleUrl: args);
        },
      },
      theme: AppTheme.lighTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.currentTheme,
    );
  }
}
