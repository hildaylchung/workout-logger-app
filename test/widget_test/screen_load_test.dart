// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:workout_logging_app/models/exercise.dart';
import 'package:workout_logging_app/models/workout.dart';
import 'package:workout_logging_app/screens/workout_list.dart';
import 'package:workout_logging_app/utils/date.dart';
import 'package:workout_logging_app/widgets/workout_list_item.dart';

void main() {
  testWidgets('Load Workout List Screen with no history', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: WorkoutList(pastWorkouts: [])),
    );

    expect(find.text('New+'), findsOne);
    expect(find.text('Workout List Screen'), findsOne);
    expect(find.text('Add Your First Workout!'), findsOne);
  });

  testWidgets('WorkoutListItem content with custom data', (tester) async {
    final DateTime now = DateTime.now();
    final SetRecord testSet = SetRecord(squatExercise, 40, 3);
    final List<SetRecord> sets = [testSet];
    final WorkoutModel testWorkout =
        WorkoutModel(now.toIso8601String(), sets, now);
    final Widget testWidget = WorkoutListItem(workout: testWorkout);
    await tester.pumpWidget(MaterialApp(home: testWidget));

    /// Expected result:
    /// - Only one list item exist
    expect(find.byType(WorkoutListItem), findsOne);
    expect(find.text("Date: ${displayDateYYYYMMDDHHMM(now)}"), findsOne);
    expect(find.text("Exercise"), findsOne);
    expect(find.text("Set 1: Squat - 40kg x 3 reps"), findsOne);
    expect(find.byType(IconButton), findsOne);
  });
}
