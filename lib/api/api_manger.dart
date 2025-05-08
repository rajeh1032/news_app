import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constant.dart';
import 'package:news_app/api/end_point.dart';
import 'package:news_app/model/source_response.dart';

class ApiManger {
  ///https://newsapi.org/v2/top-headlines/sources?apiKey=API_KEY
  static Future<SourceResponse?> getSources() async {
    Uri url = Uri.https(ApiConstant.baseUrl, EndPoint.sourceApi,
        {'apiKey': ApiConstant.apiKey});
    try {
      var response = await http.get(url);
      var bodyString = response.body;

      ///string
      //String=>json =>object
      var json = jsonDecode(bodyString); //json
      return SourceResponse.fromJson(json); //object
      // SourceResponse.fromJson(jsonDecode(response.body));}
    } catch (e) {
      throw e;
    }
  }
}
