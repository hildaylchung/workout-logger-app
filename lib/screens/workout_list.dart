// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_logging_app/text_style.dart';

// Project imports:
import '../models/workout.dart';
import '../provider/new_workout.dart';
import '../provider/workout.dart';
import '../widgets/workout_list_item.dart';

class WorkoutListScreen extends ConsumerWidget {
  const WorkoutListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HistoryWorkoutsState state = ref.watch(historyWorkoutProvider);

    /// simulate data not yet fetched and api call is needed
    if (state.lastFetched == null) {
      /// use Future.delayed to prevent changes at build error
      Future.delayed(Duration.zero, () {
        ref.read(historyWorkoutProvider.notifier).getPastWorkouts();
      });
      return const Center(child: CircularProgressIndicator());
    }

    return WorkoutList(pastWorkouts: state.pastWorkouts);
  }
}

class WorkoutList extends ConsumerWidget {
  final List<WorkoutModel> pastWorkouts;

  const WorkoutList({super.key, required this.pastWorkouts});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout List Screen"),
        actions: [
          // new workout button
          TextButton(
              onPressed: () {
                ref.read(newWorkoutProvider.notifier).reset();
                context.push('/workout');
              },
              child: Text("New+", style: AppTextStyle.actionButton))
        ],
      ),
      body: ListView(
          padding: const EdgeInsets.all(10),
          children: pastWorkouts
              .asMap()
              .map((idx, w) => MapEntry(
                  idx,
                  Padding(
                    padding: idx == 0
                        ? EdgeInsets.zero
                        : const EdgeInsets.symmetric(vertical: 8.0),
                    child: WorkoutListItem(workout: w),
                  )))
              .values
              .toList()),
    );
  }
}
