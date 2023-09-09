import 'package:firebase_database/firebase_database.dart';
import '../models/plants/plants_list_item.dart';

class PlantProvider {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('plantsList');

  Future<List<PlantsListItem>> getPlants() async {
    List<PlantsListItem> plants = [];

    final snapshot = await _dbRef.get();

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
}
