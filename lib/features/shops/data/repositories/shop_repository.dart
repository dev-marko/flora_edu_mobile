import '../providers/shop_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopRepository {
  final ShopProvider _shopProvider = ShopProvider();

  Future<List<Marker>> getShopMarkers() async {
    return await _shopProvider.getShopMarkers();
  }
}
