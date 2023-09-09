import 'dart:async';

import '../models/plants/plants_list_item.dart';
import '../providers/plant_provider.dart';

enum PlantsStatus { initial, loading, success, failure }

class PlantRepository {
  final PlantProvider _plantProvider = PlantProvider();

  Future<List<PlantsListItem>> getPlants() async {
    var plants = await _plantProvider.getPlants();
    return plants;
  }
}
