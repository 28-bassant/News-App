import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/api/models/NewsResponse.dart';

class NewsViewModel extends ChangeNotifier{
  String? errorMsg;
  List<News>? newsList;
  //todo : hold data - handle logic
  void getNews(String sourceId)async{
    //todo: reinitialize
    newsList = null;
    errorMsg = null;
    notifyListeners();
    var response =await ApiManager.getNewsBySourceId(sourceId, '');
    try{
      if(response?.status == 'error'){
        //todo: error
        errorMsg = response!.message!;
      }
      else {
        //todo : Success
        newsList = response!.articles!;
      }
    }
    catch(e){
      errorMsg = e.toString();
    }
    notifyListeners();
  }
}