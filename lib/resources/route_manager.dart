import 'package:flutter_meels_app/data/model.dart';
import 'package:flutter_meels_app/ui/screen/home/add_meal_screen.dart';
import 'package:flutter_meels_app/ui/screen/home/home_screen.dart';
import 'package:flutter_meels_app/ui/screen/home/meals_details_screen.dart';
import 'package:flutter_meels_app/ui/screen/onBoarding/on_boarding_screen.dart';
import 'package:flutter_meels_app/ui/screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoardingRoute';
  static const String homeRoute = '/home';
  static const String mealsDetailesRoute = '/mealsDetailesRoute';
  static const String addMealRoute = '/addMealRoute';
}

class RouteManager {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.splashRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.onBoardingRoute,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: Routes.homeRoute,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: Routes.mealsDetailesRoute,
        builder: (context, state) =>
            MealsDetailsScreen(cardModel: state.extra as CardModel),
      ),
      GoRoute(
        path: Routes.addMealRoute,
        builder: (context, state) => const AddMealScreen(),
      ),
    ],
  );
}
