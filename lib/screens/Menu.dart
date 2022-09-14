import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:seeds_admin/app_router.dart';
import 'package:seeds_admin/data/seed_provider.dart';
import 'package:seeds_admin/modules/meal.dart';
import 'package:seeds_admin/screens/meals_.dart/mealInfo.dart';
import 'package:seeds_admin/screens/meals_.dart/meals.dart';
import 'package:seeds_admin/seedsColors.dart';
import 'package:seeds_admin/widgets/categoryWidget.dart';
import 'package:seeds_admin/widgets/mealWidget.dart';

import '../modules/category.dart';

class Menue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: SeedsColors.secondColor,
        toolbarHeight: kToolbarHeight + kToolbarHeight / 3.5,
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 60.w),
            child: Text(
              'Seeds',
              style: TextStyle(color: SeedsColors.main, fontSize: 26.sp),
            ),
          ),
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Center(
              child: SvgPicture.asset('assets/icons/curveSeeds.svg'),
            )),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: SeedsColors.secondColor,
        ),
        child: ListView(physics: BouncingScrollPhysics(), children: [
          SizedBox(
            child: SvgPicture.asset(
              'assets/images/restaurant.svg',
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 30.h, bottom: 15.h, left: 12.w, right: 12.w),
            child: Text(
              'categoris'.tr(),
              style: TextStyle(
                color: SeedsColors.offWhite,
                fontSize: 18.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Consumer<SeedsProvider>(
              builder: (BuildContext context, provider, child) {
                List<Category> categories = provider.categories;
                return categories.isNotEmpty
                    ? GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 6.w,
                          mainAxisSpacing: 6.h,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              provider.meals = [];
                              provider.getMeals(categories[index].id!);
                              AppRouter.navigateToWidget(
                                  Meals(categories[index]));
                            },
                            child: categoryWidget(
                              categories[index],
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Lottie.asset('assets/animation/loading_pan.json',
                            height: 200.h));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 30.h, bottom: 15.h, left: 12.w, right: 12.w),
            child: Text(
              'popularDished'.tr(),
              style: TextStyle(
                color: SeedsColors.offWhite,
                fontSize: 18.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Consumer<SeedsProvider>(
              builder: (BuildContext context, provider, child) {
                List<Meal> meals = provider.popularMeals;
                return meals.isNotEmpty
                    ? SizedBox(
                        height: 116,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: meals.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (BuildContext context) {
                                      return mealInfo(
                                          context, provider, meals[index]);
                                    },
                                    context: context);
                              },
                              child: popularMealWidget(meals[index], provider),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Lottie.asset('assets/animation/loading_pan.json',
                            height: 200.h));
              },
            ),
          ),
          SizedBox(
            height: 100.h,
          )
        ]),
      ),
    );
  }

  Category category = Category(
      id: '1', title: 'Vegetables', imagePath: 'assets/icons/meat.svg');
}
