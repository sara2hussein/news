import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/api/api_constants.dart';
import 'package:news/api/end_points.dart';
import 'package:news/models/NewsResponse.dart';
import 'package:news/models/SourceResponse.dart';

class ApiManager {
  static Future<SourceResponse?> getSources() async {
    //https://newsapi.org/v2/top-headlines/sources?
    //apiKey=1f6f30142abe4d9cbf52f21cbcc7fcfb
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourseApi, {
      'apiKey': ApiConstants.apiKey,
    });
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return SourceResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  // https://newsapi.org/v2/everything?
  // q=bitcoin&apiKey=1f6f30142abe4d9cbf52f21cbcc7fcfb
  static Future<NewsResponse?> getNewsBySourceId(String sourceId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
      'apiKey': ApiConstants.apiKey,
      'sources': sourceId,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
    return  NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
