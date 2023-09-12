import '../../features/blog/presentation/screens/blogs_list_screen.dart';
import 'package:flutter/material.dart';

import '../../features/plant_gallery/screens/plant_gallery_screen.dart';
import '../../features/plants/presentation/screens/plants_list_screen.dart';
import '../../features/shops/presentation/screens/shops_map_screen.dart';
import '../screens/splash_screen.dart';

class FloraEduAppDrawer extends StatelessWidget {
  const FloraEduAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Навигација'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(PlantsListScreen.route());
            },
            leading: const Icon(Icons.grass),
            title: const Text('Растенија'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(BlogsListScreen.route());
            },
            leading: const Icon(Icons.article),
            title: const Text('Блог'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(ShopsMapScreen.route());
            },
            leading: const Icon(Icons.map),
            title: const Text('Мапа од продавници'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(PlantGalleryScreen.route());
            },
            leading: const Icon(Icons.image),
            title: const Text('Галерија'),
          ),
        ],
      ),
    );
  }
}
