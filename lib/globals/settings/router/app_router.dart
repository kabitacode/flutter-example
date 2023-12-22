import 'package:example/globals/providers/app_state_provider.dart';
import 'package:example/globals/settings/router/utils/router_utils.dart';
import 'package:example/screens/home/home.dart';
import 'package:example/screens/onboard/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  AppRouter({required this.appStateProvider, required this.prefs});

  AppStateProvider appStateProvider;
  late SharedPreferences prefs;

  get router => _router;

  late final _router = GoRouter(
      refreshListenable: appStateProvider,
      initialLocation: "/",
      routes: [
        GoRoute(
            path: APP_PAGE.home.routePath,
            name: APP_PAGE.home.routeName,
            builder: (context, state) => const Home()),
        GoRoute(
            path: APP_PAGE.onBoard.routePath,
            name: APP_PAGE.onBoard.routeName,
            builder: (context, state) => const OnBoardScreen())
      ],
      redirect: (BuildContext context, GoRouterState state) {
        //=======================change #4  start===========/

        // define the named path of onboard screen
        final String onboardPath =
            state.namedLocation(APP_PAGE.onBoard.routeName);

        // Checking if current path is onboarding or not
        bool isOnboarding = state.path == onboardPath;

        // check if sharedPref as onBoardCount key or not
        //if is does then we won't onboard else we will
        bool toOnboard = prefs.containsKey('onBoardCount') ? false : true;

        if (toOnboard) {
          // return null if the current location is already OnboardScreen to prevent looping
          return isOnboarding ? null : onboardPath;
        }
        // returning null will tell router to don't mind redirect section
        return null;
      });
}
