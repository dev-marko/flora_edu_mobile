part of 'plant_details_bloc.dart';

sealed class PlantDetailsEvent extends Equatable {
  const PlantDetailsEvent();

  @override
  List<Object> get props => [];
}

final class PlantDetailsLoad extends PlantDetailsEvent {
  final String plantId;
  const PlantDetailsLoad(this.plantId);

  @override
  List<Object> get props => [plantId];
}

final class PlantDetailsCommentChanged extends PlantDetailsEvent {
  final String content;
  const PlantDetailsCommentChanged(this.content);

  @override
  List<Object> get props => [content];
}

final class PlantDetailsCommentSubmitted extends PlantDetailsEvent {}
