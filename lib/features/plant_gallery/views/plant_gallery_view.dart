import 'package:flora_edu_mobile/features/plant_gallery/providers/plant_gallery_provider.dart';
import 'package:flora_edu_mobile/features/plant_gallery/screens/add_plant_picture_screen.dart';
import 'package:flora_edu_mobile/shared/widgets/flora_edu_app_bar.dart';
import 'package:flora_edu_mobile/shared/widgets/flora_edu_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlantGalleryView extends StatefulWidget {
  const PlantGalleryView({super.key});

  @override
  State<PlantGalleryView> createState() => _PlantGalleryViewState();
}

class _PlantGalleryViewState extends State<PlantGalleryView> {
  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const FloraEduAppBar(),
        drawer: const FloraEduAppDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context)
              .push(AddPlantPictureScreen.route())
              .then((value) => _refresh()),
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: Provider.of<PlantGalleryProvider>(context, listen: false)
              .getPlants(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<PlantGalleryProvider>(
                  child: const Center(
                    child: Text('Вашата галерија од растенија е празна.'),
                  ),
                  builder: (ctx, plantPictures, child) => plantPictures
                          .items.isEmpty
                      ? child!
                      : ListView.builder(
                          itemBuilder: (ctx, index) => ListTile(
                            key: Key(plantPictures.items[index].id),
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(plantPictures.items[index].image),
                            ),
                            title: Text(plantPictures.items[index].name),
                          ),
                          itemCount: plantPictures.items.length,
                        ),
                ),
        ));
  }
}
