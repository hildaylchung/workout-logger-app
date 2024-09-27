
// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:workout_logging_app/models/exercise.dart';
import 'package:workout_logging_app/models/workout.dart';
import 'package:workout_logging_app/utils/date.dart';


void main() {
  test('Display workout set record', () {
    final record = SetRecord(squatExercise, 40, 5);
    expect(record.toString(), equals('Squat - 40kg x 5 reps'));
  });

  test('Date format', () {
    final d = DateTime(2024, 9, 27, 13, 25);
    final result = displayDateYYYYMMDDHHMM(d);
    expect(result, equals('2024-09-27 01:25 PM'));
  });
}