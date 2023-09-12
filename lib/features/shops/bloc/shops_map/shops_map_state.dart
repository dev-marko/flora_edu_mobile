part of 'shops_map_bloc.dart';

enum ShopsMapStatus { initial, loading, success, failure }

class ShopsMapState extends Equatable {
  final ShopsMapStatus status;
  final LatLng initialLocation;
  final Set<Marker> markers;
  final Set<Polygon> polygons;
  final Set<Polyline> polylines;
  final List<LatLng> polygonLatLngs;

  final String errorMessage;

  const ShopsMapState({
    required this.status,
    required this.initialLocation,
    required this.markers,
    required this.polygons,
    required this.polylines,
    required this.polygonLatLngs,
    required this.errorMessage,
  });

  ShopsMapState copyWith({
    ShopsMapStatus? status,
    LatLng? initialLocation,
    Set<Marker>? markers,
    Set<Polygon>? polygons,
    Set<Polyline>? polylines,
    List<LatLng>? polygonLatLngs,
    String? errorMessage,
  }) {
    return ShopsMapState(
      status: status ?? this.status,
      initialLocation: initialLocation ?? this.initialLocation,
      markers: markers ?? this.markers,
      polygons: polygons ?? this.polygons,
      polylines: polylines ?? this.polylines,
      polygonLatLngs: polygonLatLngs ?? this.polygonLatLngs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, initialLocation, markers, polygons, polylines, polygonLatLngs, errorMessage];
}
