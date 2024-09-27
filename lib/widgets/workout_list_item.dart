// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import '../models/workout.dart';
import '../provider/new_workout.dart';
import '../provider/workout.dart';
import '../textStyle.dart';
import '../utils/date.dart';
import '../widgets/confirm_dialog.dart';
import 'decorated_cell_wrapper.dart';

class WorkoutListItem extends ConsumerWidget {
  final WorkoutModel workout;

  const WorkoutListItem({super.key, required this.workout});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(newWorkoutProvider.notifier).reset();
        context.push('/workout', extra: workout);
      },
      child: DecoratedCellWrapper(
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Date: ${displayDateYYYYMMDDHHMM(workout.dateCreated)}",
                    style: AppTextStyle.strong),
                const SizedBox(height: 10),
                const Text("Exercise"),
                ...workout.sets
                    .asMap()
                    .map((idx, record) =>
                        MapEntry(idx, Text("Set ${idx + 1}: $record")))
                    .values
              ],
            )),
            IconButton(
                onPressed: () async {
                  showConfirmDialog(context, () {
                    ref
                        .read(historyWorkoutProvider.notifier)
                        .deleteWorkout(workout.key);
                  });
                },
                icon: const Icon(Icons.remove_circle))
          ],
        ),
      ),
    );
  }
}
