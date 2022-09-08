import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:seeds_admin/app_router.dart';
import 'package:seeds_admin/data/seed_provider.dart';
import 'package:seeds_admin/modules/meal.dart';
import 'package:seeds_admin/screens/edit_meal.dart';
import 'package:seeds_admin/screens/meals_.dart/meals.dart';
import 'package:seeds_admin/seedsColors.dart';

popularMealWidget(Meal meal, SeedsProvider provider) {
  return Stack(
    children: [
      Container(
        margin: EdgeInsets.only(right: 20.w),
        width: 124.w,
        height: 145.h,
        decoration: BoxDecoration(
          color: SeedsColors.thirdColor,
          borderRadius: BorderRadius.circular(32.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 72.h,
              child: Image.network(
                meal.imagePath!,
              ),
            ),
            Text(
              meal.title!,
              style: TextStyle(color: SeedsColors.freeStar, fontSize: 12.sp),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 50.h,
        width: 120.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                provider.unPopular(meal.id!);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Icon(
                  Icons.delete_forever,
                  color: SeedsColors.secondMain,
                  size: 30.r,
                ),
              ),
            ),
            meal.hasSale
                ? SvgPicture.asset(
                    'assets/icons/saleTag.svg',
                    height: 10.h,
                  )
                : const SizedBox(),
          ],
        ),
      )
    ],
  );
}

mealWidget(BuildContext context, Meal meal, SeedsProvider provider) {
  return Stack(
    children: [
      Container(
        width: 166.w,
        height: 190.h,
        decoration: BoxDecoration(
          color: SeedsColors.thirdColor,
          borderRadius: BorderRadius.circular(32.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 110.w,
              height: 110.h,
              child: Image.network(
                meal.imagePath!,
              ),
            ),
            Text(
              meal.title!,
              style: TextStyle(color: SeedsColors.freeStar, fontSize: 15.sp),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 15.h),
        height: 12.h,
        child: meal.hasSale
            ? SvgPicture.asset('assets/icons/saleTag.svg')
            : const SizedBox(),
      ),
      SizedBox(
        width: 160.w,
        height: 120.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: SeedsColors.secondColor,
                        title: Text(
                          'deleteMeal'.tr(),
                          style: TextStyle(
                            color: SeedsColors.secondMain,
                            fontSize: 24.sp,
                          ),
                        ),
                        content: Text(
                          '${'deleteMealFor'.tr()}: ${meal.title} ',
                          style: TextStyle(
                            color: SeedsColors.freeStar,
                            fontSize: 18.sp,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              AppRouter.popFromWidget();
                            },
                            child: Text(
                              'cancel'.tr(),
                              style: TextStyle(color: SeedsColors.active),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return Center(
                                      child: SizedBox(
                                          height: 200.h,
                                          width: 200.h,
                                          child: Lottie.asset(
                                              'assets/animation/indecator.json')),
                                    );
                                  });
                              log('like deleted');
                              await provider.deleteMeal(
                                  meal.id!, meal.categoryId!);
                              AppRouter.navigateWithReplacemtnToWidget(Meals(
                                  provider.categories
                                      .where((element) =>
                                          element.id == meal.categoryId)
                                      .first));
                            },
                            child: Text(
                              'deleteMeal'.tr(),
                              style: TextStyle(color: SeedsColors.secondMain),
                            ),
                          ),
                        ],
                      );
                    });
              },
              child: SvgPicture.asset('assets/icons/deleteCircle.svg'),
            ),
            InkWell(
              onTap: () async {
                await provider.editMealPrepareProvider(meal);
                AppRouter.navigateToWidget(EditMeal(meal));
              },
              child: SvgPicture.asset('assets/icons/editCircle.svg'),
            ),
          ],
        ),
      )
    ],
  );
}
