import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_app/api/endpoints.dart';
import 'package:news_app/api/models/NewsResponse.dart';
import 'package:news_app/api/models/SourceResponse.dart';
import 'package:http/http.dart' as http;
import '../../api/api_constants.dart';
import '../../utils/app_colors.dart';
import '../category_details/news/news_item.dart';
import 'dart:async';



class NewsCache {
  static List<News> latestNews = [];
}

class SearchScreen extends StatefulWidget {
  final Source? source;
  final String? initialQuery;
  const SearchScreen({super.key, this.source, this.initialQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  List<News> allNews = [];
  List<News> displayedNews = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    if ((widget.initialQuery ?? '').isNotEmpty) {
      searchController.text = widget.initialQuery!;
    }

    // Start with cached news if available
    if (NewsCache.latestNews.isNotEmpty) {
      allNews = List.from(NewsCache.latestNews);
      displayedNews = List.from(allNews);
      isLoading = false;
    }

    fetchNews(query: widget.initialQuery);
  }

  Future<void> fetchNews({String? query}) async {
    setState(() {
      isLoading = true;
      error = null;
    });

    final hasSource = (widget.source?.id ?? '').isNotEmpty;
    String effectiveQuery = (query ?? widget.initialQuery ?? '').trim();

    final bool useEverything = hasSource || effectiveQuery.isNotEmpty;

    late final Uri url;
    if (useEverything) {
      if (!hasSource && effectiveQuery.isEmpty) {
        effectiveQuery = 'news';
      }
      url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
        'apiKey': ApiConstants.apiKey,
        'pageSize': '20',
        if (hasSource) 'sources': widget.source!.id!,
        if (effectiveQuery.isNotEmpty) 'q': effectiveQuery,
        'sortBy': 'publishedAt',
        'language': 'en',
      });
    } else {
      url = Uri.https(ApiConstants.baseUrl, '/v2/top-headlines', {
        'apiKey': ApiConstants.apiKey,
        'pageSize': '20',
        'country': 'us',
      });
    }

    try {
      final res = await http.get(url);
      final body = jsonDecode(res.body);

      if (res.statusCode != 200 || body['status'] != 'ok') {
        setState(() {
          isLoading = false;
          error = (body is Map && body['message'] is String)
              ? body['message']
              : 'Failed to load news';
        });
        return;
      }

      final List articles = body['articles'] ?? [];
      allNews = articles.map((e) => News.fromJson(e)).toList();

      // Save to cache
      NewsCache.latestNews = List.from(allNews);

      setState(() {
        displayedNews = List.from(allNews);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        error = e.toString();
      });
    }
  }

  void _filterNews(String query) {
    setState(() {
      if (query.isEmpty) {
        displayedNews = List.from(allNews);
      } else {
        displayedNews = allNews
            .where((news) =>
            news.title!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title:  Text("Search News",style:Theme.of(context).textTheme.labelLarge)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              style: Theme.of(context).textTheme.labelLarge,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: Theme.of(context).textTheme.headlineLarge,
                prefixIcon: Icon(Icons.search,
                    color: Theme.of(context).indicatorColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                      color: Theme.of(context).indicatorColor, width: 4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:
                  BorderSide(color: Theme.of(context).indicatorColor),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    searchController.clear();
                    displayedNews = List.from(NewsCache.latestNews);
                    setState(() {});
                  },
                  child: Icon(
                    Icons.cancel_outlined,
                    color: Theme.of(context).indicatorColor,
                  ),
                )

              ),
              controller: searchController,
              onChanged: _filterNews,
            ),
          ),
          SizedBox(height: height * .02),
          Expanded(
            child: isLoading
                ?  Center(child: CircularProgressIndicator(color: AppColors.greyColor,))
                : (error != null)
                ? Center(child: Text(error!))
                : (displayedNews.isEmpty)
                ?  Center(child: Text('No results',style:Theme.of(context).textTheme.labelLarge,))
                : ListView.builder(
              itemCount: displayedNews.length,
              itemBuilder: (context, index) =>
                  NewsItem(news: displayedNews[index]),
            ),
          ),
        ],
      ),
    );
  }
}
