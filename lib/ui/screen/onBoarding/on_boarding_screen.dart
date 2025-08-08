import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meels_app/data/sh_pr.dart';
import 'package:flutter_meels_app/resources/assets_manager.dart';
import 'package:flutter_meels_app/resources/color_manager.dart';
import 'package:flutter_meels_app/resources/route_manager.dart';
import 'package:flutter_meels_app/resources/style_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;
  late final List<Widget> _items;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _items = [
      customItem(
        title: 'Save Your Meals Ingredient',
        description:
            'Add Your Meals and its Ingredients and we will save it for you',
      ),
      customItem(
        title: 'Use Our App The Best Choice',
        description: 'the best choice for your kitchen do not hesitate',
      ),
      customItem(
        title: ' Our App\nYour Ultimate Choice',
        description:
            'All the best restaurants and their top menus are ready for you',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagesManager.welcomePageImage),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 40.h,
            left: 32.w,
            right: 32.w,
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      width: 311.w,
      height: 400.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48.r),
        color: ColorManager.primary.withAlpha((.9 * 255).round()),
      ),
      child: Column(
        children: [
          CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: 279.h,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              autoPlay: false,
              initialPage: _currentPage,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
            items: _items,
          ),
          SizedBox(height: 15.h),
          DotsIndicator(
            mainAxisSize: MainAxisSize.min,
            dotsCount: _items.length,
            position: _currentPage.toDouble(),
            onTap: (position) {
              _carouselController.animateToPage(position);
              setState(() {
                _currentPage = position.toInt();
              });
            },
            decorator: DotsDecorator(
              spacing: const EdgeInsets.only(left: 5),
              size: Size(24.w, 6.w),
              activeColor: ColorManager.white,
              activeSize: Size(24.w, 6.w),
              color: ColorManager.inactive,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          _currentPage == 2 ? SizedBox(height: 20.h) : SizedBox(height: 30.h),
          _currentPage == 2
              ? GestureDetector(
                  onTap: () async {
                    await SharedPrefsHelper.setOnBoardingScreenViewed();
                    context.pushReplacement(Routes.homeRoute);
                  },
                  child: Container(
                    width: 62.w,
                    height: 62.h,
                    decoration: const BoxDecoration(
                      color: ColorManager.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward,
                        color: ColorManager.primary,
                        size: 24.sp,
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          fixedSize: Size(30.w, 20.h),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Skip',
                          style: StyleManager.titleStyle.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        onPressed: () async {
                          await SharedPrefsHelper.setOnBoardingScreenViewed();
                          context.pushReplacement(Routes.homeRoute);
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          fixedSize: Size(30.w, 20.h),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Next',
                          style: StyleManager.titleStyle.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        onPressed: () {
                          if (_currentPage < _items.length - 1) {
                            _carouselController.nextPage();
                            setState(() {
                              _currentPage++;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget customItem({String? title, String? description}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 29.r, left: 30.r, right: 29.r),
          child: SizedBox(
            width: 254.w,
            child: Text(
              title ?? 'error in title',
              style: StyleManager.titleStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: 251.w,
          margin: EdgeInsets.only(left: 38.r, right: 22.r),
          child: Text(
            description ?? 'error in description',
            style: StyleManager.subTitleStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
