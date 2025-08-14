import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/api/models/SourceResponse.dart';
import 'package:news_app/api/models/category.dart';
import 'package:news_app/home_screen/category_details/source/source_tab_widget.dart';
import 'package:news_app/providers/app_language_provider.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatefulWidget {
  Category category;
   CategoryDetails({super.key,required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    var width = MediaQuery.of(context).size.width;
    return FutureBuilder<SourceResponse>(
        future: ApiManager.getSources(widget.category.id,languageProvider.appLanguage),
        builder: (context, snapshot) {
          //todo : Loading
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.greyColor,
              ),
            );
          }
          //todo: erreor = > Client
          else if(snapshot.hasError){
            return Center(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: width * .02),
                child: Column(
                  children: [
                    Text(AppLocalizations.of(context)!.something_went_wrong, style: Theme.of(context).textTheme.labelMedium,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.greyColor
                      ),
                        onPressed: () {
                          ApiManager.getSources(widget.category.id,languageProvider.appLanguage);
                          setState(() {

                          });

                        },
                        child: Text(AppLocalizations.of(context)!.try_again,style: Theme.of(context).textTheme.labelMedium))
                  ],
                ),
              ),
            );
          }
          //todo : Server => Success or Error Response
          if(snapshot.data?.status != 'ok'){
            return Center(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: width * .02),
                child: Column(
                  children: [
                    Text(snapshot.data!.message!, style: Theme.of(context).textTheme.labelMedium,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.greyColor
                        ),
                        onPressed: () {
                          ApiManager.getSources(widget.category.id,languageProvider.appLanguage);
                          setState(() {

                          });
                        },
                        child: Text(AppLocalizations.of(context)!.try_again,style: Theme.of(context).textTheme.labelMedium))
                  ],
                ),
              ),
            );
          }
          var sourcesList = snapshot.data?.sources ?? [];
          return SourceTabWidget(sourceList: sourcesList);
        },);
  }
}
