import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:seeds_admin/app_router.dart';
import 'package:seeds_admin/data/seed_provider.dart';
import 'package:seeds_admin/modules/reservatoinTemplate.dart';
import 'package:seeds_admin/screens/reservation%20requists.dart';
import 'package:seeds_admin/seedsColors.dart';

reservationWidget(BuildContext context, ReservationTemplate template,
    SeedsProvider provider) {
  return Container(

      // height: 200.h,
      width: 343.w,
      margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: SeedsColors.freeStar,
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Column(children: [
        SizedBox(
          width: 343.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              template.reservationStatus == 0
                  ? Container(
                      decoration: BoxDecoration(
                          color: SeedsColors.secondColor,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20.r))),
                      width: 110.w,
                      height: 25.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: SeedsColors.secondColor,
                                      title: Text(
                                        'acceptReservation'.tr(),
                                        style: TextStyle(
                                          color: SeedsColors.active,
                                          fontSize: 24.sp,
                                        ),
                                      ),
                                      content: Text(
                                        '${'tableNumberWellBeReserved'.plural(int.parse(template.tableId))} : ${template.customerFullName} ',
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
                                            style: TextStyle(
                                                color: SeedsColors.active),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            AppRouter.popFromWidget();
                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) {
                                                  return SizedBox(
                                                    height: 100.h,
                                                    width: 100.h,
                                                    child: Lottie.asset(
                                                        'assets/animation/indecator.json'),
                                                  );
                                                });
                                            await provider.acceptReservation(
                                                template.reservationId!);
                                            await Future.delayed(
                                                const Duration(seconds: 1));
                                            // AppRouter.popFromWidget();
                                            AppRouter
                                                .navigateWithReplacemtnToWidget(
                                                    ReservationRequists());
                                          },
                                          child: Text(
                                            'accept'.tr(),
                                            style: TextStyle(
                                                color: SeedsColors.active),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: SvgPicture.asset(
                              'assets/icons/reserveKit/check.svg',
                              width: 24.w,
                              color: SeedsColors.active,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        backgroundColor:
                                            SeedsColors.secondColor,
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              AppRouter.popFromWidget();
                                            },
                                            child: Text(
                                              'cancel'.tr(),
                                              style: TextStyle(
                                                  color: SeedsColors.active),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              AppRouter.popFromWidget();
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) {
                                                    return SizedBox(
                                                      height: 100.h,
                                                      width: 100.h,
                                                      child: Lottie.asset(
                                                          'assets/animation/indecator.json'),
                                                    );
                                                  });
                                              await provider.deleteReservation(
                                                template.reservationId!,
                                              );
                                              await Future.delayed(
                                                  const Duration(seconds: 1));
                                              AppRouter.popFromWidget();
                                            },
                                            child: Text(
                                              'decline'.tr(),
                                              style: TextStyle(
                                                  color:
                                                      SeedsColors.secondMain),
                                            ),
                                          ),
                                        ],
                                        title: Text(
                                          'declineRequest'.tr(),
                                          style: TextStyle(
                                              color: SeedsColors.secondMain,
                                              fontSize: 24.sp),
                                        ),
                                        content: Text(
                                          'deleteRequistContent'.tr(),
                                          style: TextStyle(
                                              color: SeedsColors.freeStar,
                                              fontSize: 20.sp),
                                        ),
                                      ));
                            },
                            child: SvgPicture.asset(
                              'assets/icons/reserveKit/cross.svg',
                              width: 20.w,
                              color: SeedsColors.secondMain,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: SeedsColors.secondColor,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20.r))),
                      width: 75.w,
                      height: 22.h,
                      child: InkWell(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: SeedsColors.secondColor,
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          AppRouter.popFromWidget();
                                        },
                                        child: Text(
                                          'cancel'.tr(),
                                          style: TextStyle(
                                              color: SeedsColors.active),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          AppRouter.popFromWidget();
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) {
                                                return SizedBox(
                                                  height: 100.h,
                                                  width: 100.h,
                                                  child: Lottie.asset(
                                                      'assets/animation/indecator.json'),
                                                );
                                              });
                                          await provider.deleteReservation(
                                            template.reservationId!,
                                          );
                                          await Future.delayed(
                                              const Duration(seconds: 1));
                                          AppRouter.popFromWidget();
                                        },
                                        child: Text(
                                          'decline'.tr(),
                                          style: TextStyle(
                                              color: SeedsColors.secondMain),
                                        ),
                                      ),
                                    ],
                                    title: Text(
                                      'declineRequest'.tr(),
                                      style: TextStyle(
                                          color: SeedsColors.secondMain,
                                          fontSize: 24.sp),
                                    ),
                                    content: Text(
                                      'deleteRequistContent'.tr(),
                                      style: TextStyle(
                                          color: SeedsColors.freeStar,
                                          fontSize: 20.sp),
                                    ),
                                  ));
                        },
                        child: SvgPicture.asset(
                          'assets/icons/reserveKit/cross.svg',
                          width: 20.w,
                          color: SeedsColors.secondMain,
                        ),
                      ),
                    )
            ],
          ),
        ),
        SizedBox(
          height: 70.h,
          width: 360.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50.r,
                backgroundColor: SeedsColors.offWhite,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                      template.customerImageUrl!,
                    )),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Text(
                template.customerFullName,
                style: TextStyle(
                  color: SeedsColors.secondColor,
                  fontSize: 16.sp,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                'assets/icons/reserveKit/person.svg',
                width: 20.w,
              ),
              Padding(
                padding: EdgeInsets.only(right: 14.w, left: 6.w),
                child: Text(
                  template.guest.toString(),
                  style: TextStyle(
                    color: SeedsColors.secondColor,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/icons/reserveKit/table.svg',
                width: 20.w,
              ),
              Padding(
                padding: EdgeInsets.only(right: 12.w, left: 6.w),
                child: Text(
                  template.tableId,
                  style: TextStyle(
                    color: SeedsColors.secondColor,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40.h,
          width: 300.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: SvgPicture.asset(
                  'assets/icons/reserveKit/calendar.svg',
                  width: 25.w,
                ),
              ),
              Text(
                DateFormat('dd, MMM hh:mm a')
                    .format(template.reservedDate)
                    .toLocale()
                    .toString(),
                style: TextStyle(color: SeedsColors.secondColor, fontSize: 12),
              ),
              const Spacer(),
              template.reservationStatus == 0
                  ? Text(
                      'pending'.tr(),
                      style:
                          TextStyle(color: SeedsColors.main, fontSize: 16.sp),
                    )
                  : Text(
                      'approved'.tr(),
                      style: TextStyle(
                          color: SeedsColors.approved, fontSize: 16.sp),
                    ),
            ],
          ),
        )
      ]));
}
