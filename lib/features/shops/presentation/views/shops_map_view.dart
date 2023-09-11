import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../shared/screens/splash_screen.dart';
import '../../bloc/shops_map/shops_map_bloc.dart';

class ShopsMapView extends StatelessWidget {
  const ShopsMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopsMapBloc, ShopsMapState>(
      builder: (context, state) {
        if (state.status == Status.initial) {
          context.read<ShopsMapBloc>().add(const ShopsMapLoad());
        }

        if (state.status == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == Status.success) {
          return _ShopsMapSuccess(bloc: BlocProvider.of<ShopsMapBloc>(context));
        }

        if (state.status == Status.failure) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const SplashScreen();
      },
      listener: (context, state) {
        if (state.status == Status.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
        }
      },
    );
  }
}

class _ShopsMapSuccess extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};

  final ShopsMapBloc bloc;

  _ShopsMapSuccess({
    required this.bloc,
  }) {
    _initializeMarkers();
  }

  void _initializeMarkers() {
    for (var marker in bloc.state.markers) {
      var currentMarker = Marker(
        markerId: marker.markerId,
        position: marker.position,
        infoWindow: InfoWindow(title: marker.infoWindow.title),
        onTap: () async => bloc.add(ShopsMapMarkerTapped(tappedMarker: marker)),
      );

      _markers.add(currentMarker);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GoogleMap(
            mapType: MapType.normal,
            polylines: bloc.state.polylines,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                bloc.state.initialLocation.latitude,
                bloc.state.initialLocation.longitude,
              ),
              zoom: 10.0,
            ),
            markers: _markers,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => bloc.add(const ShopsMapLocateNearestShop()),
              child: const Text('Лоцирај најблиска продавница'),
            ),
          ),
        ),
      ],
    );
  }
}
