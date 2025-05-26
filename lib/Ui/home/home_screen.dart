import 'package:flutter/material.dart';
import 'package:news/Ui/drawer/home_drawer.dart';
import 'package:news/Ui/home/category_details/category_details.dart';
import 'package:news/Ui/home/category_fragment.dart';
import 'package:news/models/category.dart';
import 'package:news/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearchVisible = false;
  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedCategory == null ? 'Home' : selectedCategory!.title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: [
          IconButton( 
            icon: Icon(Icons.search),
            onPressed: () {
              if (selectedCategory != null) {
                setState(() {
                  isSearchVisible = !isSearchVisible;
                });
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.blackColor,
        child: HomeDrawer(onDrawerMenuClick: onDrawerMenuClick),
      ),
      body: selectedCategory == null
          ? CategoryFragment(onButtonClick: onCategoryClick)
          : CategoryDetails(
              category: selectedCategory!,
              isSearchVisible: isSearchVisible,
            ),
    );
  }

  void onCategoryClick(Category newSelectedCategory) {
    selectedCategory = newSelectedCategory;
    setState(() {});
  }

  void onDrawerMenuClick() {
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }
}