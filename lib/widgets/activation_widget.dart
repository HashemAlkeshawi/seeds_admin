import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:seeds_admin/data/seed_provider.dart';
import 'package:seeds_admin/modules/customer.dart';
import 'package:seeds_admin/screens/activation_requists.dart';
import 'package:seeds_admin/seedsColors.dart';

import '../app_router.dart';

activationWidget(
    BuildContext context, Customer customer, SeedsProvider provider) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
    decoration: BoxDecoration(
      color: SeedsColors.freeStar,
      borderRadius: BorderRadius.circular(32.r),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Text(
              customer.fullName,
              style: TextStyle(
                color: SeedsColors.secondColor,
                fontSize: 20.sp,
              ),
            )),
        Row(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: CircleAvatar(
              radius: 46.r,
              backgroundColor: SeedsColors.offWhite,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                    customer.imageUrl!,
                  )),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customer.phone,
                style: TextStyle(
                  color: SeedsColors.secondColor,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              customer.status == 1
                  ? Text(
                      'pending'.tr(),
                      style:
                          TextStyle(color: SeedsColors.main, fontSize: 16.sp),
                    )
                  : Text(
                      'active'.tr(),
                      style: TextStyle(
                          color: SeedsColors.approved, fontSize: 16.sp),
                    ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              log('a message');
            },
            icon: Icon(
              Icons.messenger_outline_rounded,
              color: SeedsColors.thirdColor,
              size: 30.r,
            ),
          ),
        ]),
        customer.status == 1
            ? Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: SeedsColors.secondColor,
                                title: Text(
                                  'accountActivation'.tr(),
                                  style: TextStyle(
                                    color: SeedsColors.active,
                                    fontSize: 24.sp,
                                  ),
                                ),
                                content: Text(
                                  '${'activateForUser'.tr()}: ${customer.fullName} ',
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
                                      style:
                                          TextStyle(color: SeedsColors.active),
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
                                                  height: 40.h,
                                                  width: 40.h,
                                                  child: Lottie.asset(
                                                      'assets/animation/indecator.json')),
                                            );
                                          });
                                      log('like activated');
                                      await provider.upDateCustomer(
                                          customer, 2);
                                      AppRouter.navigateWithReplacemtnToWidget(
                                          ActivationRequists());
                                    },
                                    child: Text(
                                      'activate_'.tr(),
                                      style:
                                          TextStyle(color: SeedsColors.active),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Container(
                        height: 42.h,
                        decoration: BoxDecoration(
                          color: SeedsColors.active,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.r)),
                        ),
                        child: Center(
                            child: Text(
                          'accept'.tr(),
                          style: TextStyle(
                            color: SeedsColors.secondColor,
                            fontSize: 16.sp,
                          ),
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: SeedsColors.secondColor,
                                title: Text(
                                  'inactiveAccount'.tr(),
                                  style: TextStyle(
                                    color: SeedsColors.active,
                                    fontSize: 24.sp,
                                  ),
                                ),
                                content: Text(
                                  '${'decactivateForUser'.tr()}: ${customer.fullName} ',
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
                                      style:
                                          TextStyle(color: SeedsColors.active),
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
                                                  height: 300.h,
                                                  width: 300.h,
                                                  child: Lottie.asset(
                                                      'assets/animation/indecator.json')),
                                            );
                                          });

                                      await provider.upDateCustomer(
                                          customer, 0);
                                      AppRouter.navigateWithReplacemtnToWidget(
                                          ActivationRequists());
                                    },
                                    child: Text(
                                      'decline'.tr(),
                                      style:
                                          TextStyle(color: SeedsColors.active),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Container(
                        height: 42.h,
                        decoration: BoxDecoration(
                          color: SeedsColors.secondMain,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(32.r)),
                        ),
                        child: Center(
                            child: Text(
                          'decline'.tr(),
                          style: TextStyle(
                            color: SeedsColors.freeStar,
                            fontSize: 16.sp,
                          ),
                        )),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: SeedsColors.secondColor,
                              title: Text(
                                'inactiveAccount'.tr(),
                                style: TextStyle(
                                  color: SeedsColors.active,
                                  fontSize: 24.sp,
                                ),
                              ),
                              content: Text(
                                '${'inactivateForUser'.tr()}: ${customer.fullName} ',
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
                                                height: 300.h,
                                                width: 300.h,
                                                child: Lottie.asset(
                                                    'assets/animation/indecator.json')),
                                          );
                                        });

                                    await provider.upDateCustomer(customer, 0);
                                    AppRouter.navigateWithReplacemtnToWidget(
                                        ActivationRequists());
                                  },
                                  child: Text(
                                    'inactivate'.tr(),
                                    style: TextStyle(color: SeedsColors.active),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: SeedsColors.secondMain,
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(32.r)),
                      ),
                      height: 42.h,
                      child: Center(
                          child: Text(
                        'inactiveAccount'.tr(),
                        style: TextStyle(
                            color: SeedsColors.freeStar, fontSize: 16.sp),
                      )),
                    ),
                  )),
                ],
              )
      ],
    ),
  );
}
