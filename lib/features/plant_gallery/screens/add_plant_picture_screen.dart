import '../providers/plant_gallery_provider.dart';
import '../views/add_plant_picture_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPlantPictureScreen extends StatelessWidget {
  const AddPlantPictureScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const AddPlantPictureScreen());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlantGalleryProvider(),
      child: const AddPlantPictureView(),
    );
  }
}
