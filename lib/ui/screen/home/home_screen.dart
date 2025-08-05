import 'package:flutter/material.dart';
import 'package:flutter_meels_app/data/db.dart';
import 'package:flutter_meels_app/data/model.dart';
import 'package:flutter_meels_app/resources/assets_manager.dart';
import 'package:flutter_meels_app/resources/color_manager.dart';
import 'package:flutter_meels_app/resources/route_manager.dart';
import 'package:flutter_meels_app/resources/style_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _cardRate = '4.9';
  final String _cardTime = '20 - 30';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildStack(),
            _buildGridView(),
            SizedBox(height: 45.h),
            _buildAddButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildStack() {
    return SizedBox(
      height: 400.h, // ارتفاع ثابت للـ Stack
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // صورة الخلفية الرئيسية
          Image.asset(
            ImagesManager.homeAppBarImage,
            width: double.infinity,
            height: 346.h,
            fit: BoxFit.cover,
          ),
          // العناصر المتراكبة
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
            top: 120.h,
            left: 40.w,
            child: Image.asset(
              ImagesManager.background,
              width: 180.w,
              height: 186.h,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 150.h,
            left: 50.w,
            child: SizedBox(
              width: 272.w,
              height: 135.h,
              child: Text(
                'Welcome\nAdd A New Recipe',
                style: StyleManager.titleStyle.copyWith(height: 1.3),
              ),
            ),
          ),
          Positioned(
            top: 340.h,
            left: -30.w,
            child: Image.asset(
              ImagesManager.ellipse2,
              width: 146.w,
              height: 146.h,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 370.h,
            left: 10.w,
            child: Text(
              'Your Food',
              style: StyleManager.titleStyle.copyWith(
                color: ColorManager.secondary,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 22.w,
        mainAxisSpacing: 44.h,
        childAspectRatio: 153.w / 179.h, // نسبة العرض للارتفاع
        children: [
          _itemCard(image: ImagesManager.card1, title: 'Cheese Burger'),
          _itemCard(image: ImagesManager.card2, title: 'Pasta'),
          _itemCard(image: ImagesManager.card3, title: 'Breakfast'),
          _itemCard(image: ImagesManager.card4, title: 'Fries'),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: InkWell(
        customBorder: const CircleBorder(),
        radius: 12,
        onTap: () {},
        child: Container(
          width: 80.w,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 15.w, bottom: 10.h),
          height: 80.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: ColorManager.primary, width: 2),
          ),
          child: const FaIcon(
            FontAwesomeIcons.plus,
            size: 40,
            color: ColorManager.primary,
          ),
        ),
      ),
    );
  }

  Widget _itemCard({String? image, String? title}) {
    Future<int> addDataToDataBase() async {
      return await DbHelper.insert(
        CardModel(image: image, title: title, rate: _cardRate, time: _cardTime),
      );
    }

    return GestureDetector(
      onTap: () async {
        await addDataToDataBase();
        context.push(
          Routes.mealsDetailesRoute,
          extra: CardModel(
            image: image,
            title: title,
            rate: _cardRate,
            time: _cardTime,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
              color: ColorManager.inactive.withAlpha((.4 * 255).round()),
              spreadRadius: 0,
              blurRadius: 60.r,
              offset: const Offset(6, 6),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  CustomCachedNetworkImage(imageUrl: image!, width: 137, height: 106),
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(8.r),
                child: Image.asset(
                  image!,
                  width: 137.w,
                  height: 106.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8.h),
              Text(title ?? 'No title', style: StyleManager.cardTitleStyle),
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: ColorManager.primary,
                        size: 16,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _cardRate,
                        style: StyleManager.cardTitleStyle.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.solidClock,
                        color: ColorManager.primary,
                        size: 16,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        _cardTime,
                        style: StyleManager.cardTitleStyle.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
