import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import '../models/plants/plant_comment.dart';
import '../models/plants/plant_details.dart';
import 'package:uuid/uuid.dart';

import '../models/plants/plants_list_item.dart';
import '../providers/plant_provider.dart';

class PlantRepository {
  final PlantProvider _plantProvider = PlantProvider();

  Future<List<PlantsListItem>> getPlants() async {
    var plants = await _plantProvider.getPlants();
    return plants;
  }

  Future<PlantDetails> getDetailsForPlant(String plantId) async {
    return await _plantProvider.getDetailsForPlant(plantId);
  }

  Future<void> addCommentToPlant(String plantId, String content) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var plantComment = PlantComment(
        id: const Uuid().v4(),
        plantId: plantId,
        userId: user.uid,
        userEmail: user.email!,
        createdAt: DateTime.now(),
        content: content,
      );
      _plantProvider.addCommentToPlant(plantComment);
    }
  }
}
