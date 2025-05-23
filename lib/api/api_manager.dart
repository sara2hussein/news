import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/api/api_constants.dart';
import 'package:news/api/end_points.dart';
import 'package:news/models/NewsResponse.dart';
import 'package:news/models/SourceResponse.dart';

class ApiManager {
  static Future<SourceResponse?> getSources(String categoryId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourseApi, {
      'apiKey': ApiConstants.apiKey,
      'category': categoryId,
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

  static Future<NewsResponse?> getNewsBySourceId(
    String sourceId, {
    int page = 1,
    int pageSize = 20,
    String? query,
  }) async {
    final params = {
      'apiKey': ApiConstants.apiKey,
      'sources': sourceId,
      'page': '$page',
      'pageSize': '$pageSize',
    };

    if (query != null && query.isNotEmpty) {
      params['q'] = query;
    }

    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, params);
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
