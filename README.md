# workout_logging_app

A new Flutter project for tracking user workout

## Getting Started

This project made use of mainly `riverpod` and `GoRouter` packages for creating `WorkoutListScreen` and `WorkoutScreen`. And its main functionalities are logging training workout sessions of a user.

Only following workout exercises are included for now: Barbell row, Bench press, Shoulder press, Deadlift, Squat and user will be able to choose them from a dropdown. 

No Api is called in this project and sample data are returned from get function in provider for the current implementation.

## Project Composition
Project itself consists of several directories, such as models, providers, screens, widgets and utils.

- `models/`: storing data model structure, supposed to be same/similar structure as that at the server/database
- `providers/`: contains notifiers and providers, which can cause widgets watching corresponding provider refreshing at state changes. It also is where api call should be held in.
- `screens/`: storing the two screens 
- `widgets/`: storing used widgets which is not directly linked to GoRouter to make project neat and clean
- `utils/`: contains some helper functions which doesn't involve any widget creation

GoRouter related route config are stored in `route.dart` and reused TextStyle are stored in `text_style.dart` and 

## Screen Functionalities
1. Workout List Screen
    - Able to display different history workouts
    - Remove History workout (with a simple confirm dialog here)
    - Add New Workout
2. Workout Screen
    - Form with `DropdownButtonFormField`, `TextFormField` with provider `NewWorkoutState` and `TextEditingController` in `NewWorkoutModel` for managing the data
    - Able to remove one of the sets 
    - Able to add more set
    - Save workout

## Third party packages

### Riverpods
`flutter_riverpod`, `riverpod` packages are used for state management. Related state and notifier are stored in `/provider`

Packages links are as followed:
- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)
- [riverpod](https://github.com/rrousselGit/riverpod)

### [intl](https://pub.dev/packages/intl)
This package is for formatting date for displaying in titles, list items etc. It is used in `date.dart` in a date formatting function

### [GoRouter](https://pub.dev/packages/go_router)
This package is a routing package and related code are stored in `route.dart` and the router is used in `routeConfig` field in `main.dart`

### [Sort Imports](https://pub.dartlang.org/packages/import_sorter)
This package is used for sorting imports so that imports are organized and neat
Run by `flutter pub run import_sorter:main`

## Testing
Tests are added in `/test` directory which includes unit testing and some widget testing

### Unit testing
- Printing date format print string
- Display of a set of exercise

### Widget Tests
- Test if screen are load correctly, with or without history data
- Test the flow of creating a new workout, with or without completed set 
- Test the flow of removing a workout history

## Future improvements
- Connect to a api for data
- Add more workout exercises and allow selection from a separate dialog or page
- Group sets under an exercise
- Stylings of course :)

