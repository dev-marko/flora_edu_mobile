import '../../bloc/shops_map/shops_map_bloc.dart';
import '../../data/repositories/shop_repository.dart';
import '../views/shops_map_view.dart';
import '../../../../shared/widgets/flora_edu_app_bar.dart';
import '../../../../shared/widgets/flora_edu_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopsMapScreen extends StatefulWidget {
  const ShopsMapScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ShopsMapScreen());
  }

  @override
  State<ShopsMapScreen> createState() => _ShopsMapScreenState();
}

class _ShopsMapScreenState extends State<ShopsMapScreen> {
  late final ShopRepository _shopRepository;

  @override
  void initState() {
    super.initState();
    _shopRepository = ShopRepository();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _shopRepository,
      child: BlocProvider(
        create: (_) => ShopsMapBloc(shopRepository: _shopRepository),
        child: const Scaffold(
          appBar: FloraEduAppBar(),
          drawer: FloraEduAppDrawer(),
          body: ShopsMapView(),
        ),
      ),
    );
  }
}
