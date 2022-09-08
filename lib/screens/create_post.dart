import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:seeds_admin/seedsColors.dart';
import 'package:seeds_admin/widgets/appBar.dart';

class CreatePost extends StatelessWidget {
  List<String>? SelectedDays;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SeedsColors.thirdColor,
      floatingActionButton: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: SeedsColors.active,
            borderRadius: BorderRadius.circular(16.r),
          ),
          width: 343.w,
          height: 45,
          child: Center(
              child: Text(
            'addNewPost'.tr(),
            style: TextStyle(
              color: SeedsColors.secondColor,
              fontSize: 18,
            ),
          )),
        ),
      ),
      appBar: appBar('createPost'.tr(), background: SeedsColors.thirdColor),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 12.h),
        decoration: BoxDecoration(
            color: SeedsColors.secondColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r))),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.h),
                height: 150.h,
                width: 343.w,
                decoration: BoxDecoration(
                  color: SeedsColors.thirdColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                    left: 30.w,
                  ),
                  child: Text(
                    'showUsWtDoyouHave'.tr(),
                    style: TextStyle(
                      color: SeedsColors.active,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 95,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 70.r,
                      backgroundColor: SeedsColors.thirdColor,
                      child: SvgPicture.asset(
                        'assets/icons/add.svg',
                      ),
                    ),
                    Text(
                      'upload4images'.tr(),
                      style: TextStyle(
                          color: SeedsColors.freeStar, fontSize: 18.sp),
                    )
                  ],
                ),
              ),
              false
                  ? Padding(
                      padding: EdgeInsets.all(16.r),
                      child: GridView.builder(
                          itemCount: 4,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              child: Image.asset('assets/images/meal.png'),
                              color: Colors.red,
                              height: 30.h,
                              width: 30.w,
                            );
                          }),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
