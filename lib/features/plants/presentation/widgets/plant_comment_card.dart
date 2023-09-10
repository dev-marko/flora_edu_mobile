import '../../data/models/plant_comment.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlantCommentCard extends StatelessWidget {
  final PlantComment comment;

  const PlantCommentCard({required this.comment, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.account_circle),
                Text(comment.userEmail),
                Text(DateFormat.yMMMd().add_jm().format(comment.createdAt)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Text(comment.content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
