import '../../cubit/blogs_list_cubit.dart';
import '../../data/repositories/blog_repository.dart';
import '../views/blogs_list_view.dart';
import '../../../../shared/widgets/flora_edu_app_bar.dart';
import '../../../../shared/widgets/flora_edu_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogsListScreen extends StatefulWidget {
  const BlogsListScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const BlogsListScreen());
  }

  @override
  State<BlogsListScreen> createState() => _BlogsListScreenState();
}

class _BlogsListScreenState extends State<BlogsListScreen> {
  late final BlogRepository _blogRepository;

  @override
  void initState() {
    super.initState();
    _blogRepository = BlogRepository();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _blogRepository,
      child: BlocProvider(
        create: (_) => BlogsListCubit(blogRepository: _blogRepository),
        child: const Scaffold(
          appBar: FloraEduAppBar(),
          drawer: FloraEduAppDrawer(),
          body: BlogsListView(),
        ),
      ),
    );
  }
}
