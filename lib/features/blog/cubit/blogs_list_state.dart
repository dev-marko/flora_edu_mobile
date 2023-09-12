part of 'blogs_list_cubit.dart';

sealed class BlogsListState extends Equatable {
  const BlogsListState();

  @override
  List<Object> get props => [];
}

// enum BlogsListStatus { initial, loading, success, failure }

final class BlogsListInitial extends BlogsListState {
  const BlogsListInitial() : super();
}

final class BlogsListSuccess extends BlogsListState {
  final List<ArticleItem> articles;

  const BlogsListSuccess({required this.articles}) : super();

  @override
  List<Object> get props => [articles];
}

final class BlogsListLoading extends BlogsListState {
  const BlogsListLoading();
}

final class BlogsListFailure extends BlogsListState {
  final String errorMessage;

  const BlogsListFailure({required this.errorMessage}) : super();
}
