import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/api/models/NewsResponse.dart';
import 'package:news_app/api/models/SourceResponse.dart';
import 'package:news_app/home_screen/category_details/news/news_item.dart';
import 'package:news_app/providers/app_language_provider.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_colors.dart';

class NewsWidget extends StatefulWidget {
  Source source;
  NewsWidget({required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return FutureBuilder<NewsResponse>(
        future: ApiManager.getNewsBySourceId(widget.source.id ?? '',),
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
                          ApiManager.getNewsBySourceId(widget.source.id ?? '',);
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
                          ApiManager.getNewsBySourceId(widget.source.id ?? '',);
                          setState(() {

                          });
                        },
                        child: Text(AppLocalizations.of(context)!.try_again,style: Theme.of(context).textTheme.labelMedium))
                  ],
                ),
              ),
            );
          }
          var newsList = snapshot.data?.articles ?? [];
          return ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(
                height: height * .02,
              );
            },
              itemBuilder: (context, index) {
                return NewsItem(news: newsList[index]);
              },
          itemCount: newsList.length,);
        },);
  }
}
