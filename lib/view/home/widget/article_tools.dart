import 'dart:convert';
import '../../../model/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

String convertArticlesToJson(List<Articles> articles) {
  List<Map<String, dynamic>> articlesJson = articles.map((article) => article.toJson()).toList();
  return jsonEncode(articlesJson);
}



Future<void> saveArticlesToLocalStorage(List<Articles> articles) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonString = convertArticlesToJson(articles);
  await prefs.setString('articles', jsonString);
}

Future<String?> getArticlesFromLocalStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('articles');
}

List<Articles> convertJsonToArticles(String jsonString) {
  List<dynamic> articlesJson = jsonDecode(jsonString);
  return articlesJson.map((json) => Articles.fromJson(json)).toList();
}

Future<List<Articles>> loadArticlesFromLocalStorage() async {
  String? jsonString = await getArticlesFromLocalStorage();
  if (jsonString != null) {
    return convertJsonToArticles(jsonString);
  }
  return [];
}


