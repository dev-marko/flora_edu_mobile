import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Shop extends Equatable {
  final String id;
  final String name;
  final String address;
  final LatLng coordinates;

  const Shop({
    required this.id,
    required this.name,
    required this.address,
    required this.coordinates,
  });

  @override
  List<Object?> get props => [id];
}
