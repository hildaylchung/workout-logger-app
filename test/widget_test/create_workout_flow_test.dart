import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout_logging_app/route.dart';
import 'package:workout_logging_app/screens/workout.dart';
import 'package:workout_logging_app/screens/workout_list.dart';
import 'package:workout_logging_app/widgets/workout_list_item.dart';

void main() {
  testWidgets('Test Save empty new workout (with GoRouter and Provider)',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // store initial number of history workout in a variable and compare later
    final initialHistoryWorkoutsWidgets =
        tester.widgetList(find.byType(WorkoutListItem));
    final int initialNumOfHistoryWorkouts =
        initialHistoryWorkoutsWidgets.length;

    /// Test 1: Click New Workout Button
    /// Expected Result:
    /// - It should go to Workout Screen with New Workout as title
    /// - Only one Editable Record (one set row) should be displayed
    final newWorkoutBtn = find.text('New+');
    final newWorkoutResp = await tester.press(newWorkoutBtn);
    await newWorkoutResp.up();
    await tester.pumpAndSettle();

    expect(find.text('New Workout'), findsOne);
    expect(find.byType(WorkoutScreen), findsOne);

    final addExerciseBtn = find.byType(AddRecordButton);
    final saveExerciseBtn = find.byType(SaveWorkoutButton);
    expect(addExerciseBtn, findsOne);
    expect(saveExerciseBtn, findsOne);
    expect(find.byType(EditableRecord), findsOne);

    /// Test 2: Click Add Exercise Button
    /// Expected Result:
    /// - One more EditableRecord widget should be added
    final addExerciseClickResp = await tester.press(addExerciseBtn);
    await addExerciseClickResp.up();
    await tester.pumpAndSettle();
    expect(find.byType(EditableRecord), findsExactly(2));

    /// Test 3: Click Remove Exercise Button in one of the set
    /// Expected Result:
    /// - The first row is removed
    final removeSetBtns = find.byType(IconButton);
    final removeSetClickResp = await tester.press(removeSetBtns.first);
    await removeSetClickResp.up();
    await tester.pumpAndSettle();
    expect(find.byType(EditableRecord), findsOne);

    /// Test 4: Click Save Workout without any set completed
    /// Expected Result:
    /// - Go back to WorkoutListScreen
    /// - No new record is saved
    final saveEmptyWorkoutResp = await tester.press(saveExerciseBtn);
    await saveEmptyWorkoutResp.up();
    await tester.pumpAndSettle();
    expect(find.byType(WorkoutListScreen), findsOne);

    // should be same as the initial number
    expect(find.byType(WorkoutListItem),
        findsExactly(initialNumOfHistoryWorkouts));
  });

}
