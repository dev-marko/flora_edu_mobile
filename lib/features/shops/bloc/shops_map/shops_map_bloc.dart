import 'dart:async';

import 'package:equatable/equatable.dart';
import '../../data/repositories/shop_repository.dart';
import '../../services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

part 'shops_map_event.dart';
part 'shops_map_state.dart';

class ShopsMapBloc extends Bloc<ShopsMapEvent, ShopsMapState> {
  final ShopRepository _shopRepository;
  final LocationService _locationService = LocationService();

  ShopsMapBloc({required ShopRepository shopRepository})
      : _shopRepository = shopRepository,
        super(const ShopsMapState(
          status: Status.initial,
          initialLocation: LatLng(41.9287974706416, 21.522592234934194),
          markers: {},
          polygons: {},
          polylines: {},
          polygonLatLngs: [],
          errorMessage: '',
        )) {
    on<ShopsMapLoad>(_onLoad);
    on<ShopsMapMarkerTapped>(_onMapMarkerTapped);
    on<ShopsMapLocateNearestShop>(_onLocateNearestShop);
  }

  Future<void> _onLoad(
    ShopsMapLoad event,
    Emitter<ShopsMapState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));

      var markers = <Marker>{};

      var markersFromDb = await _shopRepository.getShopMarkers();

      for (var marker in markersFromDb) {
        markers.add(marker);
      }

      emit(state.copyWith(
        status: Status.success,
        markers: markers,
      ));
    } catch (err) {
      emit(state.copyWith(errorMessage: err.toString()));
    }
  }

  Future<void> _onMapMarkerTapped(
    ShopsMapMarkerTapped event,
    Emitter<ShopsMapState> emit,
  ) async {
    try {
      var directions = await _locationService.getDirections(
        '${state.initialLocation.latitude},${state.initialLocation.longitude}',
        '${event.tappedMarker.position.latitude},${event.tappedMarker.position.longitude}',
      );

      List<PointLatLng> points = directions['polyline_decoded'];

      var polylines = <Polyline>{...state.polylines};

      polylines.add(
        Polyline(
          polylineId: PolylineId(const Uuid().v4()),
          width: 6,
          color: Colors.blue,
          points: points
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList(),
        ),
      );

      emit(state.copyWith(
        status: Status.success,
        polylines: polylines,
      ));
    } catch (err) {
      emit(state.copyWith(errorMessage: err.toString()));
    }
  }

  Future<void> _onLocateNearestShop(
    ShopsMapLocateNearestShop event,
    Emitter<ShopsMapState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    var location = Location();

    var serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    var permissionGranted = await location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    var currentLocation = await location.getLocation();

    var shopLocations = state.markers;
    var minDistance = double.maxFinite;
    Marker minLocation = Marker(markerId: MarkerId(const Uuid().v4()));

    for (var shop in shopLocations) {
      var distance = Geolocator.distanceBetween(
        currentLocation.latitude!,
        currentLocation.longitude!,
        shop.position.latitude,
        shop.position.longitude,
      );

      distance = distance / 1000;

      if (distance < minDistance) {
        minDistance = distance;
        minLocation = shop;
      }
    }

    var directions = await _locationService.getDirections(
      '${currentLocation.latitude},${currentLocation.longitude}',
      '${minLocation.position.latitude},${minLocation.position.longitude}',
    );

    List<PointLatLng> points = directions['polyline_decoded'];

    var polylines = <Polyline>{...state.polylines};

    polylines.add(
      Polyline(
        polylineId: PolylineId(const Uuid().v4()),
        width: 6,
        color: Colors.blue,
        points: points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList(),
      ),
    );

    emit(state.copyWith(
      status: Status.success,
      polylines: polylines,
    ));
  }
}
