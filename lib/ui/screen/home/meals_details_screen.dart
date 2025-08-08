import 'package:flutter/material.dart';
import 'package:flutter_meels_app/data/model.dart';
import 'package:flutter_meels_app/resources/color_manager.dart';
import 'package:flutter_meels_app/resources/style_manager.dart';
import 'package:flutter_meels_app/ui/widgets/cashed_network_image.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStack(widget.cardModel.image!),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.only(left: 24.r, bottom: 24.r, right: 24.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.cardModel.title ?? '',
                  style: StyleManager.subTitleStyle.copyWith(
                    fontSize: 24.sp,
                    color: ColorManager.secondary,
                  ),
                ),
                SizedBox(height: 20.h),
                // time and rate
                Container(
                  width: 327.w,
                  height: 33.h,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: ColorManager.primary.withAlpha((.1 * 255).round()),
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
                            '${widget.cardModel.rate ?? 'No rating'}',
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
                // Divider
                SizedBox(
                  width: double.infinity,
                  height: 2.h,
                  child: const Divider(color: Color(0xffEDEDED), thickness: 2),
                ),
                SizedBox(height: 24.h),
                // Description
                Text(
                  'Description',
                  style: StyleManager.titleStyle.copyWith(
                    fontSize: 16.sp,
                    color: ColorManager.secondary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  widget.cardModel.description ?? 'No description',
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
      ),
    );
  }

  Widget _buildStack(String image) {
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
            child: CustomCachedNetworkImage(
              imageUrl: image,
              height: 327.h,
              width: 359.w,
            ),
            //  Image.asset(
            //   image,
            //   width: 359.w,
            //   height: 327.h,
            //   fit: BoxFit.fill,
            // ),
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
