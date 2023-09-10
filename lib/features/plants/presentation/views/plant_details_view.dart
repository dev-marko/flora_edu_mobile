
import '../../blocs/plant_details/plant_details_bloc.dart';
import '../../data/models/plant_details.dart';

import '../../../../shared/screens/splash_screen.dart';
import '../widgets/plant_comment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlantDetailsView extends StatelessWidget {
  final String plantId;
  const PlantDetailsView({required this.plantId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlantDetailsBloc, PlantDetailsState>(
      builder: (context, state) {
        if (state is PlantDetailsLoading) {
          context.read<PlantDetailsBloc>().add(PlantDetailsLoad(plantId));
        }

        if (state is PlantDetailsSuccess) {
          return _PlantDetailsSuccess(details: state.details);
        }

        if (state is PlantDetailsFailure) {
          return const Center(child: CircularProgressIndicator());
        }

        return const SplashScreen();
      },
      listener: (context, state) {
        if (state is PlantDetailsFailure) {
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

class _PlantDetailsSuccess extends StatelessWidget {
  final PlantDetails details;

  const _PlantDetailsSuccess({required this.details});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              details.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  details.coverImageUrl.toString(),
                ),
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(
              height: 12.0,
            ),
            const Text(
              'Опис',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(details.description),
            ),
            const Text(
              'Предуслови',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(details.prerequisites),
            ),
            const Text(
              'Садење',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(details.planting),
            ),
            const Text(
              'Одржување',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(details.maintenance),
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    key: Key('${details.plantId}_commentInput'),
                    onChanged: (content) => context
                        .read<PlantDetailsBloc>()
                        .add(PlantDetailsCommentChanged(content)),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      label: const Text('Остави коментар...'),
                      floatingLabelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      focusColor: Theme.of(context).colorScheme.secondary,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                IconButton.filled(
                  onPressed: () => context
                      .read<PlantDetailsBloc>()
                      .add(PlantDetailsCommentSubmitted()),
                  icon: const Icon(Icons.send_rounded),
                ),
              ],
            ),
            const SizedBox(
              height: 12.0,
            ),
            details.comments.isNotEmpty
                ? Column(
                    children: details.comments
                        .map((comment) => PlantCommentCard(comment: comment))
                        .toList(),
                  )
                : const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Нема коментари.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
