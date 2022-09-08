import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:seeds_admin/app_router.dart';
import 'package:seeds_admin/data/seed_provider.dart';
import 'package:seeds_admin/screens/Menu.dart';
import 'package:seeds_admin/screens/activation_requists.dart';
import 'package:seeds_admin/screens/reservation%20requists.dart';
import 'package:seeds_admin/seedsColors.dart';
import 'package:seeds_admin/widgets/add_category.dart';
import 'package:seeds_admin/screens/add_new_meal.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SeedsProvider>(
      builder: (BuildContext context, provider, child) {
        return Scaffold(
          appBar: null,
          backgroundColor: SeedsColors.secondColor,
          body: RefreshIndicator(
            onRefresh: () {
              print("refreshed");
              return provider.getSummery();
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 12.w, right: 12.w, top: 65.h, bottom: 120.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 32.w, bottom: 40.h),
                      child: Text(
                        DateFormat('dd, MMM \nEEEE..').format(DateTime.now()),
                        style: TextStyle(
                          color: SeedsColors.active,
                          fontSize: 40.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 32.w, bottom: 10.h),
                      child: Row(
                        children: [
                          Text(
                            'reservationsToday'.tr(),
                            style: TextStyle(
                                color: SeedsColors.freeStar, fontSize: 18.sp),
                          ),
                          //Provider
                          Padding(
                            padding: EdgeInsets.only(left: 6.w),
                            child: provider.summeryReservations == null
                                ? CircularProgressIndicator(
                                    color: SeedsColors.active,
                                  )
                                : Text(
                                    provider.summeryReservations.toString(),
                                    style: TextStyle(
                                        color: SeedsColors.active,
                                        fontSize: 20.sp),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 32.w, bottom: 30.h),
                      child: Row(
                        children: [
                          Text(
                            'guestsToday'.tr(),
                            style: TextStyle(
                                color: SeedsColors.freeStar, fontSize: 18.sp),
                          ),
                          //Provider
                          Padding(
                            padding: EdgeInsets.only(left: 6.w),
                            child: provider.summeryGuests == null
                                ? CircularProgressIndicator(
                                    color: SeedsColors.active,
                                  )
                                : Text(
                                    provider.summeryGuests.toString(),
                                    style: TextStyle(
                                        color: SeedsColors.active,
                                        fontSize: 20.sp),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        provider.getReservationRequists();
                        AppRouter.navigateToWidget(ReservationRequists());
                      },
                      child: Container(
                        height: 45.h,
                        width: 338.w,
                        margin: EdgeInsets.only(bottom: 15.h),
                        decoration: BoxDecoration(
                          color: SeedsColors.thirdColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 32.w),
                              child: Text(
                                'reservationRequists'.tr(),
                                style: TextStyle(
                                  color: SeedsColors.freeStar,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 32.w),
                              child: Lottie.asset(
                                  'assets/animation/arrows.json',
                                  width: 45.w,
                                  height: 45.h),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 45.h,
                      width: 338.w,
                      margin: EdgeInsets.only(bottom: 15.h),
                      decoration: BoxDecoration(
                        color: SeedsColors.thirdColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () async {
                          provider.getActivationRequists();
                          AppRouter.navigateToWidget(ActivationRequists());
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 32.w),
                              child: Text(
                                'activationRequists'.tr(),
                                style: TextStyle(
                                  color: SeedsColors.freeStar,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 32.w),
                              child: Lottie.asset(
                                  'assets/animation/arrows.json',
                                  width: 45.w,
                                  height: 45.h),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 45.h,
                      width: 338.w,
                      margin: EdgeInsets.only(bottom: 15.h),
                      decoration: BoxDecoration(
                        color: SeedsColors.thirdColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () async {
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

                          await Provider.of<SeedsProvider>(context,
                                  listen: false)
                              .getAllCategories();
                          await Provider.of<SeedsProvider>(context,
                                  listen: false)
                              .getPopularMeals();
                          AppRouter.popFromWidget();
                          AppRouter.navigateToWidget(Menue());
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 32.w),
                              child: Text(
                                'editMenu'.tr(),
                                style: TextStyle(
                                  color: SeedsColors.freeStar,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 32.w),
                              child: Lottie.asset(
                                  'assets/animation/arrows.json',
                                  width: 45.w,
                                  height: 45.h),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10.h),
                            height: 45.h,
                            width: 270.w,
                            decoration: BoxDecoration(
                              color: SeedsColors.thirdColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () {
                                AppRouter.navigateToWidget(AddNewMeal());
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 30.w,
                                    ),
                                    child: Text(
                                      'addNewMeal'.tr(),
                                      style: TextStyle(
                                        color: SeedsColors.freeStar,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(right: 30.w),
                                    child: SvgPicture.asset(
                                        'assets/icons/add.svg'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            height: 45.h,
                            width: 270.w,
                            decoration: BoxDecoration(
                              color: SeedsColors.thirdColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (ctxt) => addCategory());
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 30.w,
                                    ),
                                    child: Text(
                                      'addNewCategory'.tr(),
                                      style: TextStyle(
                                        color: SeedsColors.freeStar,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(right: 30.w),
                                    child: SvgPicture.asset(
                                        'assets/icons/add.svg'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
