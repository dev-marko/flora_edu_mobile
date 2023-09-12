import 'dart:io';

import 'package:equatable/equatable.dart';

class PlantPicture extends Equatable {
  final String id;
  final String name;
  final File image;

  const PlantPicture({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [id];
}
