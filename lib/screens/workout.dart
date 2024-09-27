// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import '../models/exercise.dart';
import '../models/workout.dart';
import '../provider/new_workout.dart';
import '../provider/workout.dart';
import '../text_style.dart';
import '../utils/date.dart';

class WorkoutScreen extends ConsumerWidget {
  final WorkoutModel? workout;

  WorkoutScreen({super.key, this.workout});

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NewWorkoutState state = ref.watch(newWorkoutProvider);

    if (state.workout == null) {
      Future.delayed(Duration.zero, () {
        ref.read(newWorkoutProvider.notifier).initializeNewWorkout(workout);
      });
      return Container();
    }

    void save() {
      ref.read(newWorkoutProvider.notifier).syncTextFieldData();

      if (formKey.currentState != null && !formKey.currentState!.validate()) {
        return;
      }

      // save into history
      ref.read(newWorkoutProvider.notifier).saveWorkout();
      ref
          .read(historyWorkoutProvider.notifier)
          .updateWorkoutToHistoryList(state.workout!.toWorkoutModel()!);
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(workout != null
              ? "Workout at ${displayDateYYYYMMDDHHMM(workout!.dateCreated)}"
              : "New Workout")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
          child: ListView(children: [
            ...state.workout!.sets
                .asMap()
                .map((idx, record) => MapEntry(
                      idx,
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: EditableRecord(
                            key: Key(record.toString()),
                            index: idx,
                            record: record),
                      ),
                    ))
                .values,
            const AddRecordButton(),
            SaveWorkoutButton(save: save),
          ]),
        ),
      ),
    );
  }
}

class EditableRecord extends ConsumerWidget {
  final int index;
  final NewSetRecord record;

  const EditableRecord({super.key, required this.index, required this.record});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          FractionallySizedBox(
            widthFactor: 0.4,
            child: DropdownButtonFormField(
              value: record.exercise?.name,
              items: exerciseChoices
                  .map((c) =>
                      DropdownMenuItem(value: c.name, child: Text(c.name)))
                  .toList(),
              onChanged: (c) {
                record.exercise =
                    exerciseChoices.firstWhere((e) => e.name == c);
                ref.read(newWorkoutProvider.notifier).updateSet(index, record);
              },
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.25,
            child: TextFormField(
              controller: record.weightTextController,
              decoration: InputDecoration(
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: 'Weight',
                  suffixText: "kg",
                  suffixStyle: AppTextStyle.suffix),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.2,
            child: TextFormField(
              controller: record.repsTextController,
              decoration: InputDecoration(
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: '',
                  suffixText: "reps",
                  suffixStyle: AppTextStyle.suffix),
            ),
          ),
          SizedBox(
              width: 25,
              height: 25,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  visualDensity: const VisualDensity(vertical: -4),
                  onPressed: () {
                    ref.read(newWorkoutProvider.notifier).removeSet(index);
                  },
                  icon: const Icon(Icons.remove_circle))),
        ]);
  }
}

class AddRecordButton extends ConsumerWidget {
  const AddRecordButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
        child: ElevatedButton(
            onPressed: () {
              ref.read(newWorkoutProvider.notifier).addSet();
            },
            child: const Text("Add Exercise")));
  }
}

class SaveWorkoutButton extends StatelessWidget {
  final Function save;

  const SaveWorkoutButton({super.key, required this.save});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: () {
              save();
              context.pop();
            },
            child: const Text("Save Workout")));
  }
}
