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
          onPressed: () => Navigator.of(context).push(AddPlantPictureScreen.route()).then((value) => _refresh()),
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: Provider.of<PlantGalleryProvider>(context, listen: false).getPlants(),
          builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<PlantGalleryProvider>(
                  child: const Center(
                    child: Text('Вашата галерија од растенија е празна.'),
                  ),
                  builder: (ctx, plantPictures, child) => plantPictures.items.isEmpty
                      ? child!
                      : GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: plantPictures.items.length,
                          itemBuilder: (context, index) {
                            return GridTile(
                              child: InkWell(
                                onTap: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 450,
                                              height: 450,
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  alignment: FractionalOffset.topCenter,
                                                  image: FileImage(
                                                    plantPictures.items[index].image,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 7.0),
                                          Text(plantPictures.items[index].name),
                                          const SizedBox(height: 7.0),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Close',
                                              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      alignment: FractionalOffset.topCenter,
                                      image: FileImage(
                                        plantPictures.items[index].image,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
        ));
  }
}
