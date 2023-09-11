import 'dart:io';

import 'package:flora_edu_mobile/features/plant_gallery/helpers/db_helper.dart';
import 'package:flora_edu_mobile/features/plant_gallery/models/plant_picture.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PlantGalleryProvider with ChangeNotifier {
  List<PlantPicture> _items = [];
  final uuid = const Uuid();

  List<PlantPicture> get items {
    return [..._items];
  }

  PlantPicture findPlantById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addPlant(String plantName, File plantImage) async {
    final newPlace = PlantPicture(
      id: uuid.v4(),
      name: plantName,
      image: plantImage,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_plants', {
      'id': newPlace.id,
      'name': newPlace.name,
      'image': newPlace.image.path,
    });
  }

  Future<void> getPlants() async {
    final dataList = await DBHelper.getData('user_plants');
    _items = dataList
        .map(
          (e) => PlantPicture(
            id: e['id'],
            name: e['name'],
            image: File(e['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
