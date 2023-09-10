import '../../../data/models/plants/plants_list_item.dart';
import '../../screens/plants/plant_details_screen.dart';
import 'package:flutter/material.dart';

class PlantCard extends StatelessWidget {
  final PlantsListItem plant;

  const PlantCard({required this.plant, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          PlantDetailsScreen.route(plant.id),
        ),
        child: ListTile(
          key: Key(plant.id),
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 0.0),
            child: Image.network(plant.previewImageUrl.toString()),
          ),
          title: Text(
            plant.plantName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          horizontalTitleGap: 32.0,
          visualDensity: const VisualDensity(vertical: 4.0),
        ),
      ),
    );
  }
}
