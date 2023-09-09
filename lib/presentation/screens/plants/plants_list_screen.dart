import '../../../blocs/plants_list/plants_list_bloc.dart';
import '../../../data/repositories/plant_repository.dart';
import '../../views/plants/plants_list_view.dart';
import '../../../shared/widgets/flora_edu_app_drawer.dart';
import '../../../shared/widgets/flora_edu_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlantsListScreen extends StatefulWidget {
  const PlantsListScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const PlantsListScreen());
  }

  @override
  State<PlantsListScreen> createState() => _PlantsListScreenState();
}

class _PlantsListScreenState extends State<PlantsListScreen> {
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
        create: (_) => PlantsListBloc(plantRepository: _plantRepository),
        child: const Scaffold(
          appBar: FloraEduAppBar(),
          drawer: FloraEduAppDrawer(),
          body: PlantsListView(),
        ),
      ),
    );
  }
}
