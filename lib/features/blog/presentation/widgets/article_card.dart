import 'package:flora_edu_mobile/features/blog/cubit/blogs_list_cubit.dart';
import 'package:flora_edu_mobile/features/blog/data/models/article_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';

class ArticleCard extends StatelessWidget {
  final ArticleItem item;

  const ArticleCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                item.coverImageUrl,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.account_circle),
                    const SizedBox(width: 8.0),
                    Text("${item.author.firstName!} ${item.author.lastName!}"),
                  ],
                ),
                Text(DateFormat.yMMMd().format(item.publishedAt)),
              ],
            ),
            const SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(item.description),
              ],
            ),
            const SizedBox(height: 8.0),
            LikeButton(
              onTap: (bool isLiked) {
                if (item.isLiked) {
                  return context.read<BlogsListCubit>().unlikeArticle(item);
                } else {
                  return context.read<BlogsListCubit>().likeArticle(item);
                }
              },
              mainAxisAlignment: MainAxisAlignment.start,
              likeBuilder: (bool isLiked) {
                return item.isLiked
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(Icons.favorite_outline);
              },
              likeCount: item.likesCount,
            )
          ],
        ),
      ),
    );
  }
}
