import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/api/models/SourceResponse.dart';

class SourcesViewModel extends ChangeNotifier{
  //todo : hold data - handle logic
  List<Source>? sourcesList;
  String? errorMessage;



  void getSources(String categoryId)async{
    //todo : reinitialize
    sourcesList = null;
    errorMessage = null;
    notifyListeners();
    var response = await ApiManager.getSources(categoryId, '');
   try{
     if(response?.status == 'error'){
       //todo : error
       errorMessage = response!.message;
     }
     else{
       //todo : Success
       sourcesList = response!.sources!;
     }
   }
   catch(e){
     errorMessage = e.toString();
   }
   notifyListeners();
  }


}