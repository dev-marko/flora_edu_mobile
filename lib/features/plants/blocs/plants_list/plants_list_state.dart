part of 'plants_list_bloc.dart';

sealed class PlantsListState extends Equatable {
  final List<PlantsListItem> plants;
  final String query;

  const PlantsListState({
    required this.plants,
    required this.query,
  });

  @override
  List<Object> get props => [plants];
}

final class PlantsListLoading extends PlantsListState {
  PlantsListLoading() : super(plants: [], query: "");
}

final class PlantsListFailure extends PlantsListState {
  PlantsListFailure({required this.errorMessage})
      : super(plants: [], query: "");
  final String errorMessage;
}

final class PlantsListSuccess extends PlantsListState {
  const PlantsListSuccess({
    required List<PlantsListItem> plants,
  }) : super(
          plants: plants,
          query: "",
        );
}
