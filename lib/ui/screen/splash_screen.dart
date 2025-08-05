import 'package:flutter/material.dart';
import 'package:flutter_meels_app/data/sh_pr.dart';
import 'package:flutter_meels_app/resources/color_manager.dart';
import 'package:flutter_meels_app/resources/route_manager.dart';
import 'package:flutter_meels_app/resources/style_manager.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _onBoardingScreenState();
  }

  _onBoardingScreenState() async {
    await Future.delayed(const Duration(seconds: 2));
    final viewed = await SharedPrefsHelper.isOnBoardingScreenViewed();
    if (viewed) {
      context.go(Routes.homeRoute);
    } else {
      context.go(Routes.onBoardingRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Splash Screen',
              style: StyleManager.titleStyle.copyWith(
                color: ColorManager.primary,
              ),
            ),
            CircularProgressIndicator(color: ColorManager.primary),
          ],
        ),
      ),
    );
  }
}
