import 'package:flutter/material.dart';
import 'package:news_app/api/models/category.dart';
import 'package:news_app/home_screen/category_fragment/widget/category_item.dart';
import 'package:provider/provider.dart';

import '../../providers/app_theme_provider.dart';

typedef OnCategoryItemClick = Function(Category);
class CategoryFragment extends StatelessWidget {
  OnCategoryItemClick onCategoryItemClick;
  List<Category> categoryList = [];
  CategoryFragment({super.key,required this.onCategoryItemClick});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    categoryList = Category.getCategoryList(themeProvider);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: width * .04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Good Morning\nHere is Some News For You',style: Theme.of(context).textTheme.headlineMedium,),
          SizedBox(height: height * .02,),
          Expanded(child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onCategoryItemClick(categoryList[index]);
                  },
                    child: CategoryItem(index: index,category: categoryList[index],));
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: height * .02,);
              },
              itemCount: 7))

        ],
      ),
    );
  }
}
