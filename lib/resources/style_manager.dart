import 'package:flutter/material.dart';
import 'package:flutter_meels_app/resources/font_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StyleManager {
  static TextStyle titleStyle = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeightManager.semiBold,
    fontFamily: FontConstants.fontFamilyInter,
    color: Colors.white,
  );
  static TextStyle subTitleStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightManager.regular,
    fontFamily: FontConstants.fontFamilyInter,
    color: Colors.white,
  );
  static TextStyle cardTitleStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightManager.medium,
    fontFamily: FontConstants.fontFamilyInter,
    color: const Color(0xff101010),
  );
}
