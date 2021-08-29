import 'dart:async';

import 'package:admin_flutter_snippets/src/models/news.dart';
import 'package:admin_flutter_snippets/src/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  static const _news = 'news';

  static Future<String> createNews(News news) async {
    final docNews = FirebaseFirestore.instance.collection(_news).doc();
    news.id = docNews.id;

    await docNews.set(news.toJson());

    return docNews.id;
  }

  static Stream<List<News>> readNews() => FirebaseFirestore.instance
      .collection(_news)
      .orderBy(NewsField.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(News().fromJson) as StreamTransformer<
          QuerySnapshot<Map<String, dynamic>>, List<News>>);

  static Future<void> updateNews(News news) async {
    final docNews = FirebaseFirestore.instance.collection(_news).doc(news.id);

    await docNews.update(news.toJson());
  }

  static Future<void> deleteNews(News news) async {
    final docNews = FirebaseFirestore.instance.collection(_news).doc(news.id);

    await docNews.delete();
  }
}
