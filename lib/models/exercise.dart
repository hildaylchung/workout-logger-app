// Alternatively, This following code can be replaced by an api call
// fetching from the server or some kind of remote config
// so that it can be updated dynamically even after the app is released
final barbellRowExercise = ExerciseModel("Barbell row");
final benchPressExercise = ExerciseModel("Bench press");
final shoulderPressExercise = ExerciseModel("Shoulder press");
final deadliftExercise = ExerciseModel("Deadlift");
final squatExercise = ExerciseModel("Squat");
final List<ExerciseModel> exerciseChoices = [
  barbellRowExercise,
  benchPressExercise,
  shoulderPressExercise,
  deadliftExercise,
  squatExercise
];

class ExerciseModel {
  String name;

  // In real implementation, exercise should be assigned with key or uuid for precise comparision
  // Tips: instructions or videos can be added here

  @override
  bool operator ==(Object other) {
    return other is ExerciseModel && name == other.name;
  }

  ExerciseModel(this.name);
}
