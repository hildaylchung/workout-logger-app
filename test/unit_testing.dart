
// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:workout_logging_app/models/exercise.dart';
import 'package:workout_logging_app/models/workout.dart';


void main() {
  // unit test
  test('Display workout set record', () {
    final record = SetRecord(squatExercise, 40, 5);
    expect(record.toString(), equals('Squat - 40kg x 5 reps'));
  });
}