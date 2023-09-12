import 'package:flora_edu_mobile/features/blog/data/models/article_item.dart';
import 'package:flora_edu_mobile/features/blog/data/repositories/blog_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'blogs_list_state.dart';

class BlogsListCubit extends Cubit<BlogsListState> {
  final BlogRepository _blogRepository;

  BlogsListCubit({required BlogRepository blogRepository})
      : _blogRepository = blogRepository,
        super(const BlogsListInitial());

  Future<void> loadBlogArticles() async {
    try {
      emit(const BlogsListLoading());
      var articles = await _blogRepository.getArticles();
      emit(BlogsListSuccess(articles: articles));
    } catch (err) {
      emit(BlogsListFailure(errorMessage: err.toString()));
    }
  }

  Future<bool> likeArticle(ArticleItem article) async {
    try {
      await _blogRepository.likeArticle(article);

      var articles = await _blogRepository.getArticles();

      emit(BlogsListSuccess(articles: articles));
      return true;
    } catch (err) {
      emit(BlogsListFailure(errorMessage: err.toString()));
      return false;
    }
  }

  Future<bool> unlikeArticle(ArticleItem article) async {
    try {
      await _blogRepository.unlikeArticle(article);

      var articles = await _blogRepository.getArticles();

      emit(BlogsListSuccess(articles: articles));
      return false;
    } catch (err) {
      emit(BlogsListFailure(errorMessage: err.toString()));
      return true;
    }
  }
}
