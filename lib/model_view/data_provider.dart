import 'package:guid/model/data.dart';
import 'package:flutter/material.dart';
import 'package:guid/view/home/widget/article_tools.dart';

class DataProvider extends ChangeNotifier {
  Data data = Data();
  List<Articles> savedArticles = [];

  void setData(Data data) {
    this.data = data;
    notifyListeners();
  }

  void setSavedArticles() {
    loadArticlesFromLocalStorage().then((articles) {
      savedArticles = articles;
      notifyListeners();
    });
  }

  void saveArticle(Articles article) async {
    List<Articles> articles = await loadArticlesFromLocalStorage();
    // Add article to saved articles
    articles.add(article);
    // Save article
    saveArticlesToLocalStorage(articles);
    // Update saved articles
    savedArticles = articles;
    notifyListeners();
  }

  Future removeArticle(Articles article) async {
    savedArticles.remove(article);
    saveArticlesToLocalStorage(savedArticles);
    notifyListeners();
  }
  
  bool isArticleSaved(Articles article) {
    return savedArticles.contains(article);
  }

  Data getData() {
    return data;
  }
}
