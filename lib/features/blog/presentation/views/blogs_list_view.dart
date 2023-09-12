import 'package:flora_edu_mobile/features/blog/cubit/blogs_list_cubit.dart';
import 'package:flora_edu_mobile/features/blog/data/models/article_item.dart';
import 'package:flora_edu_mobile/features/blog/presentation/widgets/article_card.dart';
import 'package:flora_edu_mobile/shared/screens/splash_screen.dart';
import 'package:flora_edu_mobile/shared/widgets/list_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogsListView extends StatelessWidget {
  const BlogsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogsListCubit, BlogsListState>(
      builder: (context, state) {
        if (state is BlogsListInitial) {
          context.read<BlogsListCubit>().loadBlogArticles();
        }

        if (state is BlogsListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is BlogsListSuccess) {
          return _BlogsListSuccess(
            articles: state.articles,
            cubit: BlocProvider.of<BlogsListCubit>(context),
          );
        }

        if (state is BlogsListFailure) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const SplashScreen();
      },
      listener: (context, state) {
        if (state is BlogsListFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
        }
      },
    );
  }
}

class _BlogsListSuccess extends StatelessWidget {
  final List<ArticleItem> articles;
  final BlogsListCubit cubit;

  const _BlogsListSuccess({
    required this.articles,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const PageStorageKey(0),
      shrinkWrap: true,
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ArticleCard(
            item: articles[index],
          ),
        );
      },
    );
  }
}
