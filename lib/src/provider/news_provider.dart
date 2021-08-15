import 'package:admin_flutter_snippets/src/api/firebase_api.dart';
import 'package:admin_flutter_snippets/src/model/news.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  List<News> _news = [];

  List<News> get news =>
      _news.where((news) => news.isDisabled == false).toList();

  List<News> get newsDisabled =>
      _news.where((news) => news.isDisabled == true).toList();

  void setNews(List<News>? news) =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _news = news!;
        notifyListeners();
      });

  void addNews(News news) => FirebaseApi.createNews(news);

  void updateNews(News news, String title, String description) {
    news
      ..title = title
      ..description = description;

    FirebaseApi.updateNews(news);
  }

  bool? toggleNewsStatus(News news) {
    news.isDisabled = !news.isDisabled!;

    FirebaseApi.updateNews(news);
    return news.isDisabled;
  }

  void removeNews(News news) => FirebaseApi.deleteNews(news);
}
