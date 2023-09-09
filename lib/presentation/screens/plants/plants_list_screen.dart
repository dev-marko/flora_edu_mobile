import 'package:flora_edu_mobile/blocs/plants_list/plants_list_bloc.dart';
import 'package:flora_edu_mobile/data/repositories/plant_repository.dart';
import 'package:flora_edu_mobile/presentation/views/plants/plants_list_view.dart';
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
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Plants'),
          ),
          body: const PlantsListView(),
        ),
      ),
    );
  }
}
