part of 'shops_map_bloc.dart';

sealed class ShopsMapEvent extends Equatable {
  const ShopsMapEvent();

  @override
  List<Object> get props => [];
}

final class ShopsMapLoad extends ShopsMapEvent {
  const ShopsMapLoad();
}

final class ShopsMapMarkerTapped extends ShopsMapEvent {
  final Marker tappedMarker;

  const ShopsMapMarkerTapped({
    required this.tappedMarker,
  });
}

final class ShopsMapLocateNearestShop extends ShopsMapEvent {
  const ShopsMapLocateNearestShop();
}
