import 'package:news/utils/assets_manager.dart';

class Category {
  String id;
  String title;

  String image;
  Category({required this.id, required this.title, required this.image});

  static List<Category> getCategoriesList(bool isDark) {
    return [
      Category(
        id: 'general',
        title: 'General',
        image:
            isDark == true
                ? AssetsManager.general_dark
                : AssetsManager.general_light,
      ),
      Category(
        id: 'business',
        title: 'Business',
        image:
            isDark == true
                ? AssetsManager.business_dark
                : AssetsManager.business_light,
      ),

      Category(
        id: 'entertainment',
        title: 'Entertainment',
        image:
            isDark == true
                ? AssetsManager.entertainment_dark
                : AssetsManager.entertainment_light,
      ),
      Category(
        id: 'technology',
        title: 'Technology',
        image:
            isDark == true
                ? AssetsManager.technology_dark
                : AssetsManager.technology_light,
      ),

      Category(
        id: 'science',
        title: 'Science',
        image:
            isDark == true
                ? AssetsManager.science_dark
                : AssetsManager.science_light,
      ),
      Category(
        id: 'health',
        title: 'Health',
        image:
            isDark == true
                ? AssetsManager.health_dark
                : AssetsManager.health_light,
      ),
      Category(
        id: 'sports',
        title: 'Sports',
        image:
            isDark == true
                ? AssetsManager.sports_dark
                : AssetsManager.sports_light,
      ),
    ];
  }
}
