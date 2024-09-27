// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'models/workout.dart';
import 'screens/workout.dart';
import 'screens/workout_list.dart';

/// The route configuration.
final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const WorkoutListScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'workout',
          builder: (BuildContext context, GoRouterState state) {
            WorkoutModel? data = state.extra as WorkoutModel?;
            return WorkoutScreen(workout: data);
          },
        ),
      ]),
]);
