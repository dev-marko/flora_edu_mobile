import 'package:firebase_database/firebase_database.dart';
import 'package:flora_edu_mobile/features/authentication/data/models/flora_edu_user.dart';
import 'package:flora_edu_mobile/features/blog/data/models/article_item.dart';

class BlogProvider {
  final FirebaseDatabase _dbInstance = FirebaseDatabase.instance;

  Future<List<ArticleItem>> getArticles() async {
    List<ArticleItem> articles = [];

    final snapshot = await _dbInstance.ref('articles').get();

    if (snapshot.exists && snapshot.value != null) {
      final articlesMap = snapshot.value as Map;
      articlesMap.forEach((articleId, data) {
        articles.add(
          ArticleItem(
            id: articleId,
            title: data['title'],
            author: FloraEduUser(
              id: data['author']['id'],
              firstName: data['author']['firstName'],
              lastName: data['author']['lastName'],
              email: data['author']['email'],
            ),
            publishedAt: DateTime.parse(data['publishedAt']),
            description: data['description'],
            likesCount: data['likesCount'],
            coverImageUrl: data['coverImageUrl'],
            isLiked: data['isLiked'],
          ),
        );
      });
    }

    return articles;
  }

  Future<void> likeArticle(ArticleItem articleItem) async {
    final ref = _dbInstance.ref('articles/${articleItem.id}');

    await ref.update({
      "likesCount": articleItem.likesCount + 1,
      "isLiked": true,
    });
  }

  Future<void> unlikeArticle(ArticleItem articleItem) async {
    final ref = _dbInstance.ref('articles/${articleItem.id}');

    await ref.update({
      "likesCount": articleItem.likesCount - 1,
      "isLiked": false,
    });
  }
}
