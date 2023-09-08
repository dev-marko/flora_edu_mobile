import 'package:flora_edu_mobile/blocs/plants_list/plants_list_bloc.dart';
import 'package:flora_edu_mobile/data/models/plants/plants_list_item.dart';
import 'package:flora_edu_mobile/presentation/screens/splash_screen.dart';
import 'package:flora_edu_mobile/presentation/widgets/plants/plant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlantsListView extends StatelessWidget {
  const PlantsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlantsListBloc, PlantsListState>(
      builder: (context, state) {
        if (state is PlantsListLoading) {
          context.read<PlantsListBloc>().add(const PlantsListRefresh());
        }

        if (state is PlantsListSuccess) {
          return _PlantsListSuccess(plants: state.plants);
        }

        if (state is PlantsListFailure) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const SplashScreen();
      },
      listener: (context, state) {
        if (state is PlantsListFailure) {
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

class _PlantsListSuccess extends StatelessWidget {
  final List<PlantsListItem> plants;

  const _PlantsListSuccess({required this.plants});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  maxWidth: MediaQuery.of(context).size.width,
                  minHeight: 50.0,
                  maxHeight: 50.0,
                ),
                leading: const Icon(Icons.search),
                elevation: const MaterialStatePropertyAll(2.0),
                shape: MaterialStateProperty.all(
                  const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 550.0,
                ),
                child: Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                        key: UniqueKey(),
                        shrinkWrap: true,
                        itemCount: plants.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PlantCard(plant: plants[index]),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 15,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.0),
                                Theme.of(context).scaffoldBackgroundColor,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
