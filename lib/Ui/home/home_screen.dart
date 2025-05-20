import 'package:flutter/material.dart';
import 'package:news/Ui/drawer/home_drawer.dart';
import 'package:news/Ui/home/category_details/category_details.dart';
import 'package:news/Ui/home/category_fragment.dart';
import 'package:news/utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: Theme.of(context).textTheme.headlineLarge),
      ),
      drawer: Drawer(
        backgroundColor: AppColors.blackColor,
        child: HomeDrawer()),
      body: CategoryFragment(),
    );
  }
}
