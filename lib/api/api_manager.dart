import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/api/endpoints.dart';
import 'package:news_app/api/models/NewsResponse.dart';
import 'package:news_app/api/models/SourceResponse.dart';
import 'package:provider/provider.dart';

import '../providers/app_language_provider.dart';

class ApiManager {
  static late AppLanguageProvider languageProvider;

  static void setLanguageProvider(BuildContext context) {
    languageProvider = Provider.of<AppLanguageProvider>(context, listen: false);
  }
  static Future<SourceResponse>? getSources() async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi, {
      'apiKey': ApiConstants.apiKey,
    });
    var response = await http.get(url);
    var responseBody = response.body; //todo: String
    //todo : String => json
    var json = jsonDecode(responseBody);
    //todo: json = > object
    return SourceResponse.fromJson(json);
  }

  static Future<NewsResponse>? getNewsBySourceId(String sourceId) async{
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
      'apiKey': ApiConstants.apiKey,
      'sources': sourceId,

    });
    var response = await http.get(url);
    var responseBody = response.body; //todo: String
    //todo : String => Json
    var json = jsonDecode(responseBody);
    //todo : Json => Object
    return NewsResponse.fromJson(json);

  }

}
