import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/plant_details.dart';
import '../../data/repositories/plant_repository.dart';

part 'plant_details_event.dart';
part 'plant_details_state.dart';

class PlantDetailsBloc extends Bloc<PlantDetailsEvent, PlantDetailsState> {
  final PlantRepository _plantRepository;

  PlantDetailsBloc({required PlantRepository plantRepository})
      : _plantRepository = plantRepository,
        super(PlantDetailsLoading()) {
    on<PlantDetailsLoad>(_onLoad);
    on<PlantDetailsCommentChanged>(_onCommentContentChanged);
    on<PlantDetailsCommentSubmitted>(_onCommentSubmitted);
  }

  Future<void> _onLoad(
    PlantDetailsLoad event,
    Emitter<PlantDetailsState> emit,
  ) async {
    try {
      emit(PlantDetailsLoading());
      var plantDetails =
          await _plantRepository.getDetailsForPlant(event.plantId);
      emit(PlantDetailsSuccess(plantDetails: plantDetails));
    } catch (err) {
      emit(PlantDetailsFailure(errorMessage: err.toString()));
    }
  }

  Future<void> _onCommentContentChanged(
    PlantDetailsCommentChanged event,
    Emitter<PlantDetailsState> emit,
  ) async {
    emit(
      PlantDetailsSuccess(
          plantDetails: state.details, commentContent: event.content),
    );
  }

  Future<void> _onCommentSubmitted(
    PlantDetailsCommentSubmitted event,
    Emitter<PlantDetailsState> emit,
  ) async {
    var plantId = state.details.plantId;
    try {
      _plantRepository.addCommentToPlant(plantId, state.newCommentContent);
      emit(PlantDetailsLoading());
    } catch (err) {
      emit(PlantDetailsFailure(errorMessage: err.toString()));
    }
  }
}
