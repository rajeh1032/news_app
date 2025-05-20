import 'package:flutter/material.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/model/source_response.dart';

class SourceViewModel extends ChangeNotifier {
  //todo hold data -- handle logic
  List<Source>? sourcesList = [];
  String? errorMessage;

  void getSourcesL(String categoryId) async {
    //todo : reinitialize
    sourcesList = null;
    errorMessage = null;  
    notifyListeners();
    try {
      var response = await ApiManger.getSources(categoryId);

      if (response?.status != 'ok') {
        //todo:server Error
        errorMessage = response!.message!;
      } else {
        //todo: server response
        sourcesList = response!.sources!;
      }
    } catch (e) {
      //todo:خطأ من ناحيه العميل
      errorMessage = 'Error Loading Sources';
    }
    notifyListeners();
  }
}
