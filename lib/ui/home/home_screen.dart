import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/my_category.dart';
import 'package:news_app/ui/home/category_details/source_details.dart';
import 'package:news_app/ui/home/drawer/home_drawer.dart';
import 'package:news_app/ui/home/home_category/home_category_fragment.dart';
import 'package:news_app/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedCategory == null ? 'Home' : selectedCategory!.title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      drawer: Drawer(
        backgroundColor: AppColors.blackColor,
        child: HomeDrawer(
          onDrawerMenueClick: onDrawerClick,
        ),
      ),
      body: selectedCategory == null
          ? CategoryFragment.HomeCategoryFragment(
              onButtonClick: onCategoryClick,
            )
          : SourceDetails(
              category: selectedCategory!,
            ),
    );
  }

  MyCategory? selectedCategory;

  void onCategoryClick(MyCategory newSelectedCategory) {
    selectedCategory = newSelectedCategory;
    setState(() {});
  }

  onDrawerClick() {
    selectedCategory = null;
    setState(() {});
  }
}
