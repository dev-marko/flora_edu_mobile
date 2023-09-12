import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/plant_gallery_provider.dart';
import '../views/plant_gallery_view.dart';

class PlantGalleryScreen extends StatelessWidget {
  const PlantGalleryScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const PlantGalleryScreen());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlantGalleryProvider(),
      child: const PlantGalleryView(),
    );
  }
}
