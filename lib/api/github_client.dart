import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../modules/github/models/search_result.dart';
import '../modules/github/models/search_result_error.dart';

class GithubClient {
  GithubClient({
    http.Client? httpClient,
    this.baseUrl = "https://api.github.com/search/repositories?q=",
  }) : this.httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  Future<SearchResult> search(String term) async {
    final response = await httpClient.get(Uri.parse("$baseUrl$term"));
    log("message ::: data $response");
    final results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return SearchResult.fromJson(results);
    } else {
      throw SearchResultError.fromJson(results);
    }
  }
}
