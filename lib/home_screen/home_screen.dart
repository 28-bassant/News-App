import 'package:flutter/material.dart';
import 'package:news_app/api/models/category.dart';
import 'package:news_app/home_screen/category_details/category_details.dart';
import 'package:news_app/home_screen/category_fragment/category_fragment.dart';
import 'package:news_app/home_screen/drawer_widget/drawer_widget.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/l10n/app_localizations.dart';

import '../utils/app_assets.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedCategory == null ?
          AppLocalizations.of(context)!.home :
          selectedCategory!.title,style: Theme.of(context).textTheme.headlineLarge,),

      ),
      drawer: Drawer(
        backgroundColor: AppColors.blackColor,
        child: DrawerWidget(
          onHomeClick: onHomeClick,
        )
      ),
      body: selectedCategory == null ?
      CategoryFragment(
        onCategoryItemClick: onCategoryItemClick,
      ):
          CategoryDetails(category: selectedCategory!,)

    );
  }
  void onHomeClick(){
    selectedCategory = null;
    setState(() {

    });
  }
  Category? selectedCategory ;

  void onCategoryItemClick(Category newSelectedCategory){
    selectedCategory = newSelectedCategory;
    setState(() {

    });


  }
}
