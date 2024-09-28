// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:workout_logging_app/route.dart';
import 'package:workout_logging_app/screens/workout_list.dart';
import 'package:workout_logging_app/widgets/confirm_dialog.dart';
import 'package:workout_logging_app/widgets/workout_list_item.dart';

void main() {
  testWidgets('Test Remove History Workout (with GoRouter and Provider)',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );

    /// Test 1: Set router and load first screen
    /// Expected Result:
    /// - WorkoutListScreen widget is loaded
    /// - Loading indicator should be shown when data not yet populated/retrieved
    expect(find.byType(WorkoutListScreen), findsOne);
    expect(find.byType(WorkoutList), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOne);

    await tester.pumpAndSettle();

    /// Test 2: Settled WorkoutListScreen
    /// Expected Result:
    /// - History list screen loaded after settle
    /// - Current dummy data will create 2 WorkoutListItems
    expect(find.text('New+'), findsOne);
    expect(find.text('Workout List Screen'), findsOne);
    expect(find.byType(WorkoutList), findsOne);
    expect(find.byType(WorkoutListItem), findsExactly(2));

    /// Test 3: Click remove button in list item
    /// Expected Result:
    /// - Show up ConfirmDialog which is an AlertDialog with Confirm and Cancel button
    final removeBtns = find.byType(IconButton);
    expect(removeBtns, findsExactly(2));

    // click first remove button
    final clickRemoveBtnResp = await tester.press(removeBtns.first);
    await clickRemoveBtnResp.up();
    await tester.pumpAndSettle();

    expect(find.byType(ConfirmDialog), findsOne);
    expect(find.byType(AlertDialog), findsOne);
    expect(find.text("Do you confirm deleting?"), findsOne);

    final confirmBtn = find.text("Confirm");
    final cancelBtn = find.text("Cancel");
    expect(confirmBtn, findsOne);
    expect(cancelBtn, findsOne);

    /// Test 4: Click cancel button in dialog
    /// Expected Result:
    /// - Dialog is removed
    /// - No history is removed
    final clickCancelResp = await tester.press(cancelBtn);
    await clickCancelResp.up();
    await tester.pumpAndSettle();
    expect(find.byType(ConfirmDialog), findsNothing);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(WorkoutListItem), findsExactly(2));

    /// Test 5: Click confirm button in dialog
    /// Expected Result:
    /// - Dialog is removed
    /// - Only one WorkoutListItem is left
    final clickRemoveBtnResp2 = await tester.press(removeBtns.first);
    await clickRemoveBtnResp2.up();
    await tester.pumpAndSettle();

    // click confirm button this time
    final clickConfirmResp = await tester.press(confirmBtn);
    await clickConfirmResp.up();
    await tester.pumpAndSettle();
    expect(find.byType(ConfirmDialog), findsNothing);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(WorkoutListItem), findsOne);
  });
}
