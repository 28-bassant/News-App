import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/api/endpoints.dart';
import 'package:news_app/api/models/NewsResponse.dart';
import 'package:news_app/api/models/SourceResponse.dart';
import 'package:news_app/home_screen/search_screen/search_screen.dart';
import 'package:provider/provider.dart';

import '../providers/app_language_provider.dart';

class ApiManager {


  static Future<SourceResponse>? getSources(String category) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi, {
      'apiKey': ApiConstants.apiKey,
      'category' : category,
    });
    var response = await http.get(url);
    var responseBody = response.body; //todo: String
    //todo : String => json
    var json = jsonDecode(responseBody);
    //todo: json = > object
    return SourceResponse.fromJson(json);
  }

  static Future<NewsResponse>? getNewsBySourceId(String sourceId,String query) async{
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
      'apiKey': ApiConstants.apiKey,
      'sources': sourceId,
      'q' : query,
      'searchIn' : 'title'

    });
    var response = await http.get(url);
    var responseBody = response.body; //todo: String
    //todo : String => Json
    var json = jsonDecode(responseBody);
    //todo : Json => Object
    return NewsResponse.fromJson(json);

  }

}
