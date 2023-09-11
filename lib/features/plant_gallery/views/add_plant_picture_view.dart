import 'dart:io';

import 'package:flora_edu_mobile/features/plant_gallery/providers/plant_gallery_provider.dart';
import 'package:flora_edu_mobile/features/plant_gallery/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPlantPictureView extends StatefulWidget {
  const AddPlantPictureView({super.key});

  @override
  State<AddPlantPictureView> createState() => _AddPlantPictureViewState();
}

class _AddPlantPictureViewState extends State<AddPlantPictureView> {
  final _nameController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() async {
    if (_nameController.text.isEmpty || _pickedImage == null) {
      return;
    }

    await Provider.of<PlantGalleryProvider>(context, listen: false)
        .addPlant(_nameController.text, _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сликајте ново растение'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    label: const Text('Име на растение'),
                    floatingLabelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    focusColor: Theme.of(context).colorScheme.secondary,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  controller: _nameController,
                ),
                const SizedBox(
                  height: 32.0,
                ),
                ImageInput(onSelectImage: _selectImage),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: const Icon(Icons.add),
            label: const Text('Додади во галерија'),
          )
        ],
      ),
    );
  }
}
