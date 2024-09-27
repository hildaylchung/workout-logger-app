// Project imports:
import 'exercise.dart';

class SetRecord {
  ExerciseModel exercise;
  int weight;
  int reps;

  // some extra
  int get volume {
    return weight * reps;
  }

  @override
  String toString() {
    return '${exercise.name} - ${weight}kg x $reps reps';
  }

  SetRecord(this.exercise, this.weight, this.reps);
}

class WorkoutModel {
  String key;
  DateTime dateCreated;
  List<SetRecord> sets;

  WorkoutModel(this.key, this.sets, this.dateCreated);
}
