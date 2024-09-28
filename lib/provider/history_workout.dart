// Dart imports:
import 'dart:core';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../models/exercise.dart';
import '../models/workout.dart';
import '../utils/debug.dart';

class HistoryWorkoutsState {
  List<WorkoutModel> pastWorkouts;
  DateTime? lastFetched;

  HistoryWorkoutsState({this.pastWorkouts = const [], this.lastFetched});

  HistoryWorkoutsState copyWith(
      {List<WorkoutModel>? pastWorkouts, DateTime? lastFetched}) {
    return HistoryWorkoutsState(
        pastWorkouts: pastWorkouts ?? this.pastWorkouts,
        lastFetched: lastFetched ?? this.lastFetched);
  }
}

class HistoryWorkoutsStateNotifier extends Notifier<HistoryWorkoutsState> {
  @override
  HistoryWorkoutsState build() => HistoryWorkoutsState();

  Future<void> deleteWorkout(String key) async {
    try {
      /// api call goes here

      // on success
      List<WorkoutModel> newArr = [...state.pastWorkouts];
      newArr.removeWhere((p) => p.key == key);
      state = state.copyWith(pastWorkouts: newArr);
    } catch (err) {
      dbgPrint(err);
    }
  }

  void updateWorkoutToHistoryList(WorkoutModel workout) {
    // check key to edit/create new workout
    int index = state.pastWorkouts.indexWhere((p) => p.key == workout.key);
    if (index == -1) {
      state = state.copyWith(pastWorkouts: [workout, ...state.pastWorkouts]);
    } else {
      state = state.copyWith(pastWorkouts: [
        ...state.pastWorkouts.sublist(0, index),
        workout,
        ...state.pastWorkouts.sublist(index + 1, state.pastWorkouts.length),
      ]);
    }
  }

  Future<void> getPastWorkouts() async {
    try {
      /// api call for getting the data from server

      // TODO remove sample data and call from api
      List<SetRecord> sampleWorkout1 = [
        SetRecord(benchPressExercise, 40, 10),
        SetRecord(benchPressExercise, 45, 10),
        SetRecord(benchPressExercise, 50, 10),
        SetRecord(deadliftExercise, 70, 8),
        SetRecord(deadliftExercise, 75, 6),
      ];

      List<SetRecord> sampleWorkout2 = [
        SetRecord(benchPressExercise, 60, 1),
        ...List.filled(3, SetRecord(squatExercise, 45, 10)),
      ];

      // use uuid or some key generator
      DateTime workoutDate1 = DateTime(2024, 9, 26, 13, 0);
      DateTime workoutDate2 = DateTime(2024, 9, 25, 12, 0);
      List<WorkoutModel> pastWorkouts = [
        WorkoutModel(
            workoutDate1.toIso8601String(), sampleWorkout1, workoutDate1),
        WorkoutModel(
            workoutDate2.toIso8601String(), sampleWorkout2, workoutDate2)
      ];

      state = state.copyWith(
          pastWorkouts: pastWorkouts, lastFetched: DateTime.now());
    } catch (err) {
      dbgPrint(err);
    }
  }
}

final historyWorkoutProvider =
    NotifierProvider<HistoryWorkoutsStateNotifier, HistoryWorkoutsState>(
        HistoryWorkoutsStateNotifier.new);
