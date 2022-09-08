import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:lottie/lottie.dart';
import 'package:seeds_admin/app_router.dart';
import 'package:seeds_admin/data/seed_provider.dart';
import 'package:seeds_admin/screens/Menu.dart';
import 'package:seeds_admin/screens/edit_meal.dart';
import 'package:seeds_admin/screens/home.dart';
import 'package:seeds_admin/screens/meals_.dart/meals.dart';
import 'package:seeds_admin/seedsColors.dart';
import 'package:seeds_admin/widgets/saleTag.dart';

import '../../modules/meal.dart';

mealInfo(BuildContext context, SeedsProvider provider, Meal meal) {
  return Container(
    padding: EdgeInsets.only(top: 6.h),
    height: 570.h,
    decoration: BoxDecoration(
      color: SeedsColors.secondColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50.r),
        topRight: Radius.circular(50.r),
      ),
    ),
    child: ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: 280.h,
          width: 270.w,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 18.r),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: Image.network(
                meal.imagePath!,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        ListTile(
          title: Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              meal.title!,
              style: TextStyle(fontSize: 16.sp, color: SeedsColors.freeStar),
            ),
          ),
          trailing: SizedBox(
            width: 122.w,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              meal.hasSale ? saleTag(meal.salePrice ?? 0) : const SizedBox(),
              SizedBox(
                width: 5.w,
              ),
              priceTag(meal.price ?? 0),
            ]),
          ),
        ),
        meal.hasSale
            ? Padding(
                padding: EdgeInsets.only(left: 12.w, bottom: 12.h),
                child: Row(
                  children: [
                    Text(
                      'saleDays'.tr(),
                      style: TextStyle(
                          color: SeedsColors.goldenTextColor, fontSize: 14.sp),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      (meal.saleDays ?? "-${'noSale'.tr()}-").substring(1,
                          (meal.saleDays ?? "-${'noSale'.tr()}-").length - 1),
                      style: TextStyle(
                          color: SeedsColors.offWhite, fontSize: 14.sp),
                    )
                  ],
                ),
              )
            : const SizedBox(),
        Row(
          children: [
            const Spacer(),
            InkWell(
              onTap: () async {
                await provider.editMealPrepareProvider(meal);
                AppRouter.navigateWithReplacemtnToWidget(EditMeal(meal));
              },
              child: SvgPicture.asset(
                'assets/icons/editCircle.svg',
                width: 60.w,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 25.w),
              child: InkWell(
                onTap: () async {
                  await showDialog(
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
                                await Future.delayed(
                                    Duration(milliseconds: 1500));
                                await provider.deleteMeal(
                                    meal.id!, meal.categoryId!);
                                AppRouter.navigateWithReplacemtnToWidget(
                                    Menue());
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
                child: SvgPicture.asset(
                  'assets/icons/deleteCircle.svg',
                  width: 60.w,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            meal.descreption ?? 'The meal: ${meal.title}',
            style: TextStyle(
                fontSize: 14.sp, color: SeedsColors.freeStar.withAlpha(180)),
          ),
        ),
      ],
    ),
  );
}
