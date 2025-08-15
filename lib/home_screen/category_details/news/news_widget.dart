import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/api/models/NewsResponse.dart';
import 'package:news_app/api/models/SourceResponse.dart';
import 'package:news_app/home_screen/category_details/news/news_item.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/home_screen/category_details/news/news_view_model.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';

class NewsWidget extends StatefulWidget {
  final Source source;
  NewsWidget({required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  NewsViewModel viewModel = NewsViewModel();
  ScrollController scrollController = ScrollController();
  List<News> newsList = [];
  int page = 1;
  int pageSize = 5;
  bool isLoadMore = false;
  bool isInitialLoading = true;

  Future<void> fetchNews({bool loadMore = false}) async {
    var url = Uri.parse(
      'https://newsapi.org/v2/everything?apiKey=${ApiConstants.apiKey}&page=$page&pageSize=$pageSize&sources=${widget.source.id}',
    );

    var response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load news');
    }

    var articles = jsonDecode(response.body)['articles'] as List;
    var newItems = articles.map((e) => News.fromJson(e)).toList();

    setState(() {
      if (loadMore) {
        newsList.addAll(newItems);
      } else {
        newsList = newItems;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    viewModel.getNews(widget.source.id!);
    // Initial load
    fetchNews().then((_) {
      setState(() {
        isInitialLoading = false;
      });
    });

    // Pagination listener
    scrollController.addListener(() async {
      if (isLoadMore || scrollController.position.pixels < scrollController.position.maxScrollExtent - 50) return;

      setState(() => isLoadMore = true);
      page++;
      await fetchNews(loadMore: true);
      setState(() => isLoadMore = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
     return ChangeNotifierProvider(
         create: (context) => viewModel,
       child: Consumer<NewsViewModel>(
           builder: (context, viewModel, child) {
             if(viewModel.errorMsg != null){
               return  Center(
                 child: Padding(
                   padding:  EdgeInsets.symmetric(horizontal: width * .02),
                   child: Column(
                     children: [
                       Text(viewModel.errorMsg!, style: Theme.of(context).textTheme.labelMedium,),
                       ElevatedButton(
                           style: ElevatedButton.styleFrom(
                               backgroundColor: AppColors.greyColor
                           ),
                           onPressed: () {
                             viewModel.getNews(widget.source.id!);

                           },
                           child: Text(AppLocalizations.of(context)!.try_again,style: Theme.of(context).textTheme.labelMedium))
                     ],
                   ),
                 ),
               );
             }
             else if (isInitialLoading) {
               return Center(
                  child :CircularProgressIndicator(color: AppColors.greyColor)
               );
             }
             else if(viewModel.newsList  == null){
               return Center(
                   child: CircularProgressIndicator(color: AppColors.greyColor)
               );
             }
             else{
             return ListView.separated(
             controller: scrollController,
             separatorBuilder: (context, index) => SizedBox(height: height * .02),
             itemCount: isLoadMore ? newsList.length + 1 : newsList.length,
             itemBuilder: (context, index) {
             if (index >= newsList.length) {
             return Center(
             child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: CircularProgressIndicator(color: AppColors.greyColor),
             ),
             );
             }
             return NewsItem(news: newsList[index]);
             },
             );
             }

           },),

     );
    // if (isInitialLoading) {
    //   return Center(
    //     child: CircularProgressIndicator(color: AppColors.greyColor),
    //   );
    // }
    //
    // return ListView.separated(
    //   controller: scrollController,
    //   separatorBuilder: (context, index) => SizedBox(height: height * .02),
    //   itemCount: isLoadMore ? newsList.length + 1 : newsList.length,
    //   itemBuilder: (context, index) {
    //     if (index >= newsList.length) {
    //       return Center(
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: CircularProgressIndicator(color: AppColors.greyColor),
    //         ),
    //       );
    //     }
    //     return NewsItem(news: newsList[index]);
    //   },
    // );
  }
}

