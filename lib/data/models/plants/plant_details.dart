import 'package:equatable/equatable.dart';
import 'plant_comment.dart';

class PlantDetails extends Equatable {
  final String plantId;
  final String name;
  final Uri coverImageUrl;
  final String description;
  final String prerequisites;
  final String planting;
  final String maintenance;
  final List<PlantComment> comments;

  const PlantDetails({
    required this.plantId,
    required this.name,
    required this.coverImageUrl,
    required this.description,
    required this.prerequisites,
    required this.planting,
    required this.maintenance,
    this.comments = const [],
  });

  static final empty = PlantDetails(
    plantId: '',
    name: '',
    coverImageUrl: Uri.parse('placeholder'),
    description: '',
    prerequisites: '',
    planting: '',
    maintenance: '',
  );

  @override
  List<Object?> get props => [plantId];
}
