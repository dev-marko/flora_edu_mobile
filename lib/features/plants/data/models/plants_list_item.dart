import 'package:equatable/equatable.dart';

class PlantsListItem extends Equatable {
  final String id;
  final Uri previewImageUrl;
  final String plantName;

  const PlantsListItem({
    required this.id,
    required this.previewImageUrl,
    required this.plantName,
  });

  @override
  List<Object?> get props => [id];
}
