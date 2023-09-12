import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widgets/flora_edu_app_bar.dart';
import '../../../../shared/widgets/flora_edu_app_drawer.dart';
import '../../blocs/plant_details/plant_details_bloc.dart';
import '../../data/repositories/plant_repository.dart';
import '../views/plant_details_view.dart';

class PlantDetailsScreen extends StatefulWidget {
  final String plantId;

  const PlantDetailsScreen({required this.plantId, super.key});

  static Route<void> route(String plantId) {
    return MaterialPageRoute<void>(
      builder: (_) => PlantDetailsScreen(
        plantId: plantId,
      ),
    );
  }

  @override
  State<PlantDetailsScreen> createState() => PlantDetailsScreenState();
}

class PlantDetailsScreenState extends State<PlantDetailsScreen> {
  late final PlantRepository _plantRepository;

  @override
  void initState() {
    super.initState();
    _plantRepository = PlantRepository();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _plantRepository,
      child: BlocProvider(
        create: (_) => PlantDetailsBloc(plantRepository: _plantRepository),
        child: Scaffold(
          appBar: const FloraEduAppBar(),
          drawer: const FloraEduAppDrawer(),
          body: PlantDetailsView(
            plantId: widget.plantId,
          ),
        ),
      ),
    );
  }
}
