# workout_logging_app

A new Flutter project for tracking user workout

## Getting Started

This project made use of riverpod and GoRoute packages for creating WorkoutListScreen and WorkoutScreen.
No Api is called in this project so dummy data are stored in .... file.


## Project Composition
Project itself consists of several directories, such as models, providers, screens, widgets and utils.

- Models dir will be mainly storing data model structure, supposed to be same as that at the server
- Providers dir are where api call should be held in and if state in provider was changed, widgets watching the corresponding provider will refresh
- Screens dir are storing the two screens 
- Widgets dir is just storing those used widgets to make project neat and clean
- Utils dir are storing some helper functions which doesn't involve any widget creation

Some reused TextStyle are stored in textStyle.dart and route config are stored in route.dart

## Functionality
1. Workout List Screen
    - Able to display different history workouts
    - Remove History workout (with a simple confirm dialog here)
    - Add New Workout
2. 


### Sort imports
`flutter pub run import_sorter:main`

### 
