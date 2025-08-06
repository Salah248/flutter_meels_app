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
        title: ' Our App Your Ultimate Choice',
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
          Image.asset(
            ImagesManager.welcomePageImage,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      width: 311.w,
      height: 400.h,
      margin: EdgeInsets.symmetric(horizontal: 32.r, vertical: 40.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48.r),
        color: ColorManager.primary.withAlpha((.9 * 255).round()),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 200.h,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                autoPlay: false,
                enlargeCenterPage: false,
                initialPage: _currentPage,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
              items: _items,
            ),
          ),
          SizedBox(height: 16.h),
          DotsIndicator(
            dotsCount: _items.length,
            position: _currentPage.toDouble(),
            onTap: (position) {
              _carouselController.animateToPage(position);
              setState(() {
                _currentPage = position.toInt();
              });
            },
            decorator: DotsDecorator(
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
          SizedBox(height: 50.h),
          _currentPage == 2
              ? InkWell(
                  borderRadius: BorderRadius.zero,
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
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
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
        ],
      ),
    );
  }

  Widget customItem({String? title, String? description}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title ?? 'error in title',
          style: StyleManager.titleStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        Text(
          description ?? 'error in description',
          style: StyleManager.subTitleStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
