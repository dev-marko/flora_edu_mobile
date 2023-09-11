import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/plants_list_item.dart';
import '../../data/repositories/plant_repository.dart';

part 'plants_list_event.dart';
part 'plants_list_state.dart';

class PlantsListBloc extends Bloc<PlantsListEvent, PlantsListState> {
  final PlantRepository _plantRepository;

  PlantsListBloc({
    required PlantRepository plantRepository,
  })  : _plantRepository = plantRepository,
        super(PlantsListLoading()) {
    on<PlantsListRefresh>(_onRefresh);
    on<PlantsListQueryChanged>(_onQueryChanged);
  }

  Future<void> _onRefresh(
    PlantsListRefresh event,
    Emitter<PlantsListState> emit,
  ) async {
    try {
      emit(PlantsListLoading());
      var plants = await _plantRepository.getPlants();
      emit(PlantsListSuccess(plants: plants));
    } catch (err) {
      emit(PlantsListFailure(errorMessage: err.toString()));
    }
  }

  void _onQueryChanged(
    PlantsListQueryChanged event,
    Emitter<PlantsListState> emit,
  ) {
    var query = event.query;

    if (query.isEmpty) {
      emit(PlantsListSuccess(plants: state.plants));
    }

    var plants = state.plants;
    var filteredPlants =
        plants.where((element) => element.plantName.contains(query)).toList();

    emit(PlantsListSuccess(plants: filteredPlants));
  }
}
