part of 'plants_list_bloc.dart';

sealed class PlantsListEvent extends Equatable {
  const PlantsListEvent();

  @override
  List<Object> get props => [];
}

final class PlantsListRefresh extends PlantsListEvent {
  const PlantsListRefresh();
}

final class PlantsListQueryChanged extends PlantsListEvent {
  final String query;
  const PlantsListQueryChanged({required this.query});
}
