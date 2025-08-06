import 'package:shared_preferences/shared_preferences.dart';

const String onBoardScreenViewd = 'onBoardScreenViewd';

class SharedPrefsHelper {
  static Future<void> setOnBoardingScreenViewed() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(onBoardScreenViewd, false);
  }

  static Future<void> removeOnBoardingScreenViewed() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(onBoardScreenViewd);
  }

  static Future<bool> isOnBoardingScreenViewed() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(onBoardScreenViewd) ?? false;
  }
}
