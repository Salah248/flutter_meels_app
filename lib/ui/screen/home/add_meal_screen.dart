import 'package:flutter/material.dart';
import 'package:flutter_meels_app/resources/color_manager.dart';
import 'package:flutter_meels_app/resources/style_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _appHeader(),
              SizedBox(height: 28.h),
              _textField(title: 'Meal Name', onSubmitted: (p0) {}),
              SizedBox(height: 12.h),
              _textField(title: 'Image URL', onSubmitted: (p0) {}, height: 4),
              SizedBox(height: 12.h),
              _textField(title: 'Rate', onSubmitted: (p0) {}),
              SizedBox(height: 12.h),
              _textField(title: 'Time', onSubmitted: (p0) {}),
              SizedBox(height: 12.h),
              _textField(title: 'Description', onSubmitted: (p0) {}, height: 5),
              SizedBox(height: 70.h),
              _elevatedButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.sp,
            color: ColorManager.secondary,
          ),
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            fixedSize: Size(36.w, 36.h),
            padding: EdgeInsets.zero,
            shape: CircleBorder(
              side: BorderSide(color: const Color(0xffEDEDED), width: 1.w),
            ),
          ),
        ),
        Text(
          'Add Meal',
          style: StyleManager.titleStyle.copyWith(
            color: ColorManager.secondary,
            fontSize: 16.sp,
          ),
        ),
        const SizedBox.shrink(),
      ],
    );
  }

  Widget _textField({
    String? title,
    TextEditingController? controller,
    void Function(String)? onSubmitted,
    int? height,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: StyleManager.cardTitleStyle.copyWith(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        TextField(
          onSubmitted: onSubmitted,
          controller: controller,
          maxLines: height ?? 1,
          style: StyleManager.cardTitleStyle.copyWith(fontSize: 14.sp),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16.r),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: const Color(0xffD6D6D6),
                width: 1.w,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              gapPadding: 8.r,
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: const Color(0xffD6D6D6),
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 8.r,
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: const Color(0xffD6D6D6),
                width: 1.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _elevatedButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(327.w, 52.h),
        backgroundColor: ColorManager.primary,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
      ),
      onPressed: () {
        context.pop();
      },
      child: Text(
        'Save',
        style: StyleManager.titleStyle.copyWith(fontSize: 14.sp),
      ),
    );
  }
}
