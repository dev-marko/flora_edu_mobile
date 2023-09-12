import 'package:equatable/equatable.dart';
import 'package:flora_edu_mobile/features/authentication/data/models/flora_edu_user.dart';

class ArticleItem extends Equatable {
  final String id;
  final String title;
  final FloraEduUser author;
  final DateTime publishedAt;
  final String description;
  final int likesCount;
  final String coverImageUrl;
  final bool isLiked;

  const ArticleItem({
    required this.id,
    required this.title,
    required this.author,
    required this.publishedAt,
    required this.description,
    required this.likesCount,
    required this.coverImageUrl,
    required this.isLiked,
  });

  ArticleItem copyWith({
    String? id,
    String? title,
    FloraEduUser? author,
    DateTime? publishedAt,
    String? description,
    int? likesCount,
    String? coverImageUrl,
    bool? isLiked,
  }) {
    return ArticleItem(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      publishedAt: publishedAt ?? this.publishedAt,
      description: description ?? this.description,
      likesCount: likesCount ?? this.likesCount,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  @override
  List<Object?> get props => [id, title, author, publishedAt, description, likesCount, coverImageUrl];
}
