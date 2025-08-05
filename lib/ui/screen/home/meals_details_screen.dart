import 'package:flutter/material.dart';
import 'package:flutter_meels_app/data/db.dart';
import 'package:flutter_meels_app/data/model.dart';
import 'package:flutter_meels_app/resources/assets_manager.dart';
import 'package:flutter_meels_app/resources/color_manager.dart';
import 'package:flutter_meels_app/resources/style_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MealsDetailsScreen extends StatefulWidget {
  const MealsDetailsScreen({super.key, required this.cardModel});
  final CardModel cardModel;
  @override
  State<MealsDetailsScreen> createState() => _MealsDetailsScreenState();
}

class _MealsDetailsScreenState extends State<MealsDetailsScreen> {
  final String _desc = '';
  Future<List<Map<String, dynamic>>> _getDate() async {
    final data = await DbHelper.query(widget.cardModel);
    if (data.isNotEmpty) {
      debugPrint('data: ${data[0]}');
      return data;
    } else {
      debugPrint('No data found');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getDate(),
        builder: (context, asyncSnapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStack(),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.only(left: 24.r, bottom: 24.r, right: 24.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: widget.cardModel.title ?? '',
                        style: StyleManager.subTitleStyle.copyWith(
                          fontSize: 24.sp,
                          color: ColorManager.secondary,
                        ),
                        children: [
                          TextSpan(
                            text: '🍔',
                            style: TextStyle(fontSize: 24.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: 327.w,
                      height: 33.h,
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: ColorManager.primary.withAlpha(
                          (.1 * 255).round(),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.solidClock,
                                color: ColorManager.primary,
                                size: 16,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                widget.cardModel.time ?? 'No time',
                                style: StyleManager.subTitleStyle.copyWith(
                                  fontSize: 14.sp,
                                  color: ColorManager.desc,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: ColorManager.primary,
                                size: 16,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                widget.cardModel.rate ?? 'No rating',
                                style: StyleManager.subTitleStyle.copyWith(
                                  fontSize: 14.sp,
                                  color: ColorManager.desc,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 27.h),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                      child: const Divider(
                        color: Color(0xffEDEDED),
                        thickness: 2,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Description',
                      style: StyleManager.titleStyle.copyWith(
                        fontSize: 16.sp,
                        color: ColorManager.secondary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Burger With Meat is a typical food from our restaurant that is much in demand by many people, this is very recommended for you.',
                      style: StyleManager.subTitleStyle.copyWith(
                        fontSize: 14.sp,
                        color: ColorManager.desc,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStack() {
    return SizedBox(
      width: double.infinity,
      height: 290.h,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 359.w,
            height: 327.h,
            alignment: Alignment.center,
            margin: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Image.asset(
              widget.cardModel.image ?? '',
              width: 359.w,
              height: 327.h,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: -30.h,
            left: -30.w,
            child: Image.asset(
              ImagesManager.ellipse1,
              width: 146.w,
              height: 146.h,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 20.h,
            left: 30.h,
            child: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 20.sp,
                color: ColorManager.white,
              ),
              style: IconButton.styleFrom(
                backgroundColor: Colors.transparent,
                fixedSize: Size(36.w, 36.h),
                padding: EdgeInsets.zero,
                shape: CircleBorder(
                  side: BorderSide(color: ColorManager.white, width: 1.5.w),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
