// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../models/exercise.dart';
import '../models/workout.dart';
import '../utils/debug.dart';

class NewSetRecord {
  ExerciseModel? exercise;
  int? weight;
  int? reps;

  final TextEditingController weightTextController = TextEditingController();
  final TextEditingController repsTextController = TextEditingController();

  NewSetRecord({this.exercise, this.weight, this.reps}) {
    weightTextController.text = (weight ?? 0).toString();
    repsTextController.text = (reps ?? 0).toString();
  }

  NewSetRecord.fromSetRecord(SetRecord record)
      : this(
            exercise: record.exercise,
            weight: record.weight,
            reps: record.reps);

  bool get isCompleted => !(exercise == null || weight == null || reps == null);

  SetRecord? toSetRecord() {
    if (!isCompleted) return null;
    return SetRecord(exercise!, weight!, reps!);
  }

  @override
  String toString() {
    return "New Set Record: ${exercise?.name} - $weight kg x $reps reps";
  }
}

class NewWorkoutModel {
  String? key;
  DateTime? dateCreated;
  List<NewSetRecord> sets;

  WorkoutModel? toWorkoutModel() {
    DateTime d = dateCreated ?? DateTime.now();
    List<SetRecord> newSets = [];
    for (var s in sets) {
      if (s.toSetRecord() == null) {
        return null;
      }
      newSets.add(s.toSetRecord()!);
    }
    return WorkoutModel(d.toIso8601String(), newSets, d);
  }

  NewWorkoutModel(this.sets, {this.key, this.dateCreated});

  NewWorkoutModel.fromSavedWorkout(WorkoutModel m)
      : this(m.sets.map((s) => NewSetRecord.fromSetRecord(s)).toList(),
            key: m.key, dateCreated: m.dateCreated);
}

class NewWorkoutState {
  NewWorkoutModel? workout;

  NewWorkoutState copyWith({NewWorkoutModel? workout}) {
    return NewWorkoutState(workout: workout ?? this.workout);
  }

  NewWorkoutState({this.workout});
}

class NewWorkoutStateNotifier extends Notifier<NewWorkoutState> {
  @override
  NewWorkoutState build() => NewWorkoutState();

  void addSet() {
    state.workout!.sets = [...state.workout!.sets, NewSetRecord()];
    state = state.copyWith(workout: state.workout);
  }

  void removeSet(int index) {
    state.workout!.sets.removeAt(index);
    state = state.copyWith(workout: state.workout);
  }

  void updateSet(int idx, NewSetRecord set) {
    if (state.workout == null) return;
    state.workout!.sets[idx] = set;
    state = state.copyWith(workout: state.workout);
  }

  void initializeNewWorkout(WorkoutModel? m) {
    state = state.copyWith(
        workout: m == null
            ? NewWorkoutModel([
                NewSetRecord()
              ]) // initialize new workout with a new set for user experience
            : NewWorkoutModel.fromSavedWorkout(m));
  }

  void reset() {
    state = NewWorkoutState();
  }

  /// using TextEditingController instead of setting value provider in TextFormField.onChange
  /// to prevent screen updating and lose focus on textFields
  void syncTextFieldData() {
    for (NewSetRecord s in state.workout!.sets) {
      s.weight = int.tryParse(s.weightTextController.text);
      s.reps = int.tryParse(s.repsTextController.text);
    }
    state = state.copyWith(workout: state.workout);
  }

  Future<bool> saveWorkout() async {
    try {
      // remove in-completed sets
      state.workout!.sets.removeWhere((s) => !s.isCompleted);
      state = state.copyWith(workout: state.workout);

      /// api call goes here
      return true;
    } catch (err) {
      dbgPrint(err);
      return false;
    }
  }
}

final newWorkoutProvider =
    NotifierProvider<NewWorkoutStateNotifier, NewWorkoutState>(
        NewWorkoutStateNotifier.new);
