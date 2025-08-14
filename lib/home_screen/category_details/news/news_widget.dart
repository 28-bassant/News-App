import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/api/models/NewsResponse.dart';
import 'package:news_app/api/models/SourceResponse.dart';
import 'package:news_app/home_screen/category_details/news/news_item.dart';

import 'package:http/http.dart' as http;

import '../../../utils/app_colors.dart';

class NewsWidget extends StatefulWidget {
  final Source source;
  NewsWidget({required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  ScrollController scrollController = ScrollController();
  List<News> newsList = [];
  int page = 1;
  int pageSize = 20;
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

    if (isInitialLoading) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.greyColor),
      );
    }

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
}


// class NewsWidget extends StatefulWidget {
//   Source source;
//   NewsWidget({required this.source});
//
//   @override
//   State<NewsWidget> createState() => _NewsWidgetState();
// }
//
// class _NewsWidgetState extends State<NewsWidget> {
//   ScrollController scrollController = ScrollController();
//   List newsList  = [];
//   int page = 1;
//   int pageSize = 20;
//   bool isLoadMore = false;
//   fetchNews() async {
//     var url = Uri.parse(
//         'https://newsapi.org/v2/everything?q=bitcoin&apiKey=d6db76d56e664dcdaaba9d16262094a2&page=$page&pageSize=$pageSize'
//     );
//
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       var articles = jsonDecode(response.body)['articles'] as List;
//       setState(() {
//         newsList.addAll(articles.map((e) => News.fromJson(e)).toList());
//       });
//     }
//   }
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     fetchNews();
//     scrollController.addListener(() async{
//       if(isLoadMore) return;
//       if(scrollController.position.pixels ==
//       scrollController.position.maxScrollExtent){
//         setState(() {
//           isLoadMore = true;
//         });
//         page++;
//         await fetchNews();
//         setState(() {
//           isLoadMore = false;
//         });
//       }
//     },);
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//
//     var languageProvider = Provider.of<AppLanguageProvider>(context);
//     return Scaffold(
//       body: newsList.isEmpty
//           ? Center(child: CircularProgressIndicator(color: AppColors.greyColor))
//           : ListView.separated(
//         controller: scrollController,
//         separatorBuilder: (context, index) => SizedBox(height: height * .02),
//         itemBuilder: (context, index) {
//           return (index >= newsList.length)
//               ? Center(child: CircularProgressIndicator(color: AppColors.greyColor))
//               : NewsItem(news: newsList[index]);
//         },
//         itemCount: isLoadMore ? newsList.length + 1 : newsList.length,
//       ),
//     );
//
//   }
//
// }
/*
* FutureBuilder<NewsResponse>(
      future: ApiManager.getNewsBySourceId(widget.source.id ?? '',languageProvider.appLanguage,),
      builder: (context, snapshot) {
        //todo : Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.greyColor,
            ),
          );
        }
        //todo: erreor = > Client
        else if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .02),
              child: Column(
                children: [
                  Text(AppLocalizations.of(context)!.something_went_wrong,
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelMedium,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.greyColor
                      ),
                      onPressed: () {
                        ApiManager.getNewsBySourceId(widget.source.id ?? '',
                          languageProvider.appLanguage,);
                        setState(() {

                        });
                      },
                      child: Text(
                          AppLocalizations.of(context)!.try_again, style: Theme
                          .of(context)
                          .textTheme
                          .labelMedium))
                ],
              ),
            ),
          );
        }
        //todo : Server => Success or Error Response
        if (snapshot.data?.status != 'ok') {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .02),
              child: Column(
                children: [
                  Text(snapshot.data!.message!, style: Theme
                      .of(context)
                      .textTheme
                      .labelMedium,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.greyColor
                      ),
                      onPressed: () {
                        ApiManager.getNewsBySourceId(widget.source.id ?? '',
                          languageProvider.appLanguage,);
                        setState(() {

                        });
                      },
                      child: Text(
                          AppLocalizations.of(context)!.try_again, style: Theme
                          .of(context)
                          .textTheme
                          .labelMedium))
                ],
              ),
            ),
          );
        }
        // newsList = snapshot.data?.articles ?? [];

        return Column(
          children: [
            Text('Done',style: AppStyles.bold20White,),
        ListView.separated(
        controller: scrollController,
        separatorBuilder: (context, index) => SizedBox(height: height * .02),
        itemBuilder: (context, index) {
        return (index >= newsList.length)
        ? Center(child: CircularProgressIndicator(color: AppColors.greyColor))
            : NewsItem(news: newsList[index]);
        },
        itemCount: isLoadMore ? newsList.length + 1 : newsList.length,
        )

        ],
        );
      }
      ,);*/