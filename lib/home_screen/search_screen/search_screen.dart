import 'package:flutter/material.dart';
import 'package:news_app/api/models/NewsResponse.dart';
import 'package:news_app/api/models/SourceResponse.dart';
import 'package:news_app/api/models/category.dart';
import 'package:news_app/home_screen/category_details/category_details.dart';
import 'package:news_app/home_screen/category_details/news/news_widget.dart';
import 'package:news_app/home_screen/category_details/source/source_tab_widget.dart';
import 'package:news_app/home_screen/category_fragment/category_fragment.dart';
import 'package:news_app/providers/app_language_provider.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../../api/api_manager.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/app_theme_provider.dart';
import '../../utils/app_colors.dart';
import '../category_details/news/news_item.dart';

class SearchScreen extends StatefulWidget {
  Source source;
   SearchScreen({super.key,required this.source});
    TextEditingController searchController = TextEditingController();

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {@override
  Widget build(BuildContext context) {
  var args = ModalRoute.of(context)?.settings.arguments as CategoryFragment;

  var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Theme
                  .of(context)
                  .indicatorColor
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .02),
          child: Column(
            children: [
              TextFormField(
                controller: widget.searchController,
                style: Theme
                    .of(context)
                    .textTheme
                    .labelLarge,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: Theme
                      .of(context)
                      .textTheme
                      .headlineLarge,
                  prefixIcon: Icon(Icons.search, color: Theme
                      .of(context)
                      .indicatorColor,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: Theme
                            .of(context)
                            .indicatorColor,
                        width: 4
                    ),

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: Theme
                            .of(context)
                            .indicatorColor
                    ),

                  ),
                  suffixIcon: Icon(Icons.cancel_outlined, color: Theme
                      .of(context)
                      .indicatorColor,),

                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              args

            ],
          ),
        ),
      ),
    );
  }}