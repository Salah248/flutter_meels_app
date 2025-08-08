import 'package:flutter/material.dart';
import 'package:flutter_meels_app/data/db.dart';
import 'package:flutter_meels_app/data/model.dart';
import 'package:flutter_meels_app/resources/assets_manager.dart';
import 'package:flutter_meels_app/resources/color_manager.dart';
import 'package:flutter_meels_app/resources/route_manager.dart';
import 'package:flutter_meels_app/resources/style_manager.dart';
import 'package:flutter_meels_app/ui/widgets/cashed_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Future<List<int>> _insertTestData() async {
  //   print('insert data in _insertTestData() ');
  //   return [
  //     await DbHelper.insert(
  //       CardModel(
  //         image:
  //             'https://www.foodiesfeed.com/wp-content/uploads/ff-images/2025/01/delicious-berry-crisp-in-a-dark-serving-dish.png',
  //         title: 'Delicious Berry Crisp in a Dark Serving Dish',
  //         description:
  //             'This enticing image features a warm berry crisp topped with a golden crumble, showcasing vibrant strawberries, blueberries, and blackberries. Perfect for dessert lovers, this AI-generated photo is available for free download in high resolution at Foodiesfeed.com.',
  //         rate: 4.5,
  //         time: '30',
  //       ),
  //     ),
  //     await DbHelper.insert(
  //       CardModel(
  //         image:
  //             'https://www.foodiesfeed.com/wp-content/uploads/ff-images/2025/01/delicious-berry-crisp-in-a-dark-serving-dish.png',
  //         title: 'Delicious Berry Crisp in a Dark Serving Dish',
  //         description:
  //             'This enticing image features a warm berry crisp topped with a golden crumble, showcasing vibrant strawberries, blueberries, and blackberries. Perfect for dessert lovers, this AI-generated photo is available for free download in high resolution at Foodiesfeed.com.',
  //         rate: 4.5,
  //         time: '30',
  //       ),
  //     ),
  //     await DbHelper.insert(
  //       CardModel(
  //         image:
  //             'https://www.foodiesfeed.com/wp-content/uploads/ff-images/2025/01/delicious-berry-crisp-in-a-dark-serving-dish.png',
  //         title: 'Delicious Berry Crisp in a Dark Serving Dish',
  //         description:
  //             'This enticing image features a warm berry crisp topped with a golden crumble, showcasing vibrant strawberries, blueberries, and blackberries. Perfect for dessert lovers, this AI-generated photo is available for free download in high resolution at Foodiesfeed.com.',
  //         rate: 4.5,
  //         time: '30',
  //       ),
  //     ),
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildStack(),
            SizedBox(height: 25.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Food',
                    style: StyleManager.titleStyle.copyWith(
                      color: ColorManager.secondary,
                      fontSize: 16.sp,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await DbHelper.deleteAll();
                    },
                    icon: Icon(
                      FontAwesomeIcons.trash,
                      color: ColorManager.primary,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
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
      height: 280.h, // ارتفاع ثابت للـ Stack
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // صورة الخلفية الرئيسية
          Image.asset(
            ImagesManager.homeAppBarImage,
            width: double.infinity,
            height: 280.h,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 50.h,
            left: 30.w,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 5.r),
              width: 180.w,
              height: 186.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48.r),
                color: ColorManager.primary.withAlpha((.1 * 255).round()),
              ),
              child: Text(
                'Welcome Add A New Recipe',
                style: StyleManager.titleStyle,
                textAlign: TextAlign.left,
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
      child: FutureBuilder(
        future: DbHelper.query(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No data found\nPlease add a new recipe!😊',
                style: StyleManager.cardTitleStyle,
                textAlign: TextAlign.center,
              ),
            );
          } else if (asyncSnapshot.hasData) {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 22.w,
                mainAxisSpacing: 22.h,
                childAspectRatio: 153.w / 179.h,
              ),
              itemCount: asyncSnapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final meal = asyncSnapshot.data![index];
                debugPrint('meal: $meal');
                return _itemCard(
                  image: meal.image,
                  title: meal.title,
                  rate: meal.rate,
                  time: meal.time,
                  description: meal.description,
                );
              },
            );
          } else {
            print('asyncSnapshotError: ${asyncSnapshot.error}');
            return Center(
              child: _itemCard(
                image:
                    'https://cdn.pixabay.com/photo/2024/07/20/17/12/warning-8908707_1280.png',
                title: 'Add New Meal',
                rate: 0,
                time: '0 - 0',
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildAddButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: InkWell(
        customBorder: const CircleBorder(),
        radius: 12,
        onTap: () async {
          await context.push(Routes.addMealRoute);
          setState(() {});
        },
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
            size: 30,
            color: ColorManager.primary,
          ),
        ),
      ),
    );
  }

  Widget _itemCard({
    String? image,
    String? title,
    double? rate,
    String? time,
    String? description,
  }) {
    return GestureDetector(
      onTap: () async {
        context.push(
          Routes.mealsDetailesRoute,
          extra: CardModel(
            image: image,
            title: title,
            rate: rate,
            time: time,
            description: description,
          ),
        );
      },
      child: Hero(
        tag: image!,
        transitionOnUserGestures: true,
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
                CustomCachedNetworkImage(
                  imageUrl: image,
                  width: 137,
                  height: 106,
                ),
                // ClipRRect(
                //   borderRadius: BorderRadiusGeometry.circular(8.r),
                //   child: Image.asset(
                //     image!,
                //     width: 137.w,
                //     height: 106.h,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                SizedBox(height: 8.h),
                Text(
                  title ?? 'No title',
                  style: StyleManager.cardTitleStyle,
                  maxLines: 1,
                ),
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
                          rate.toString(),
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
                          time ?? '',
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
      ),
    );
  }
}
