import 'package:firebase_database/firebase_database.dart';
import '../models/shop.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopProvider {
  final FirebaseDatabase _dbInstance = FirebaseDatabase.instance;

  Future<List<Marker>> getShopMarkers() async {
    List<Shop> shops = [];
    List<Marker> shopMarkers = [];

    final snapshot = await _dbInstance.ref('shopLocations').get();

    if (snapshot.exists && snapshot.value != null) {
      final shopLocationsMap = snapshot.value as Map;
      shopLocationsMap.forEach((shopId, data) {
        shops.add(
          Shop(
            id: shopId,
            name: data['name'],
            address: data['address'],
            coordinates: LatLng(data['lat'], data['lng']),
          ),
        );
      });
    }

    for (var shop in shops) {
      shopMarkers.add(
        Marker(
          markerId: MarkerId(shop.name),
          position: shop.coordinates,
          infoWindow: InfoWindow(title: shop.name),
        ),
      );
    }

    return shopMarkers;
  }
}
