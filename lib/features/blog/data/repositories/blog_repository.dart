import '../models/article_item.dart';
import '../providers/blog_provider.dart';

class BlogRepository {
  final BlogProvider _blogProvider = BlogProvider();

  Future<List<ArticleItem>> getArticles() async {
    return await _blogProvider.getArticles();
  }

  Future<void> likeArticle(ArticleItem articleItem) async {
    await _blogProvider.likeArticle(articleItem);
  }

  Future<void> unlikeArticle(ArticleItem articleItem) async {
    await _blogProvider.unlikeArticle(articleItem);
  }
}
