part of 'plant_details_bloc.dart';

sealed class PlantDetailsState extends Equatable {
  final PlantDetails details;
  final String newCommentContent;

  const PlantDetailsState({
    required this.details,
    required this.newCommentContent,
  });

  @override
  List<Object> get props => [];
}

final class PlantDetailsLoading extends PlantDetailsState {
  PlantDetailsLoading()
      : super(details: PlantDetails.empty, newCommentContent: '');
}

final class PlantDetailsFailure extends PlantDetailsState {
  PlantDetailsFailure({required this.errorMessage})
      : super(details: PlantDetails.empty, newCommentContent: '');

  final String errorMessage;
}

final class PlantDetailsSuccess extends PlantDetailsState {
  const PlantDetailsSuccess({
    required PlantDetails plantDetails,
    String? commentContent,
  }) : super(details: plantDetails, newCommentContent: commentContent ?? '');

  @override
  List<Object> get props => [newCommentContent];
}