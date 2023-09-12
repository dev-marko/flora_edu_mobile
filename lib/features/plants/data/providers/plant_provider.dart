import 'package:firebase_database/firebase_database.dart';

import '../models/plant_comment.dart';
import '../models/plant_details.dart';
import '../models/plants_list_item.dart';

class PlantProvider {
  final FirebaseDatabase _dbInstance = FirebaseDatabase.instance;

  Future<List<PlantsListItem>> getPlants() async {
    List<PlantsListItem> plants = [];

    final snapshot = await _dbInstance.ref('plantsList').get();

    if (snapshot.exists && snapshot.value != null) {
      final plantsMap = snapshot.value as Map;
      plantsMap.forEach((plantId, data) {
        plants.add(
          PlantsListItem(
            id: plantId,
            previewImageUrl: Uri.parse(data['previewImageUrl']),
            plantName: data['plantName'],
          ),
        );
      });
    }

    return plants;
  }

  Future<PlantDetails> getDetailsForPlant(String plantId) async {
    final snapshot =
        await _dbInstance.ref('plantDetails').child('/$plantId').get();

    if (snapshot.exists && snapshot.value != null) {
      List<PlantComment> comments = await _getCommentsForPlant(plantId);
      var data = snapshot.value as Map;

      return PlantDetails(
        plantId: plantId,
        name: data['name'],
        coverImageUrl: Uri.parse(data['coverImageUrl']),
        description: data['description'],
        prerequisites: data['prerequisites'],
        planting: data['planting'],
        maintenance: data['maintenance'],
        comments: comments,
      );
    }

    return PlantDetails.empty;
  }

  Future<List<PlantComment>> _getCommentsForPlant(String plantId) async {
    List<PlantComment> comments = [];

    final snapshot =
        await _dbInstance.ref('plantComments').child('/$plantId').get();

    if (snapshot.exists && snapshot.value != null) {
      final commentsMap = snapshot.value as Map;
      commentsMap.forEach((commentId, data) {
        comments.add(
          PlantComment(
            id: commentId,
            plantId: plantId,
            userId: data['userId'],
            userEmail: data['userEmail'],
            createdAt: DateTime.parse(data['createdAt']),
            content: data['content'],
          ),
        );
      });
    }

    return comments;
  }

  Future<void> addCommentToPlant(PlantComment plantComment) async {
    await _dbInstance
        .ref('plantComments')
        .child('/${plantComment.plantId}/${plantComment.id}')
        .set({
      'content': plantComment.content,
      'createdAt': plantComment.createdAt.toIso8601String(),
      'userId': plantComment.userId,
      'userEmail': plantComment.userEmail,
    });
  }
}
