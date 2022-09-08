import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:seeds_admin/app_router.dart';
import 'package:seeds_admin/data/dio_helper.dart';
import 'package:seeds_admin/data/seed_provider.dart';
import 'package:seeds_admin/modules/category.dart';
import 'package:seeds_admin/seedsColors.dart';
import 'package:flutter/material.dart';
import 'package:seeds_admin/widgets/categories_list_items.dart';

class addCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> titleKey = GlobalKey<FormState>();
    return Consumer<SeedsProvider>(
      builder: (BuildContext context, provider, child) {
        return Center(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Center(
                  child: Container(
                    height: 290.h,
                    width: 285.w,
                    decoration: BoxDecoration(
                      color: SeedsColors.secondColor,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20.r),
                          child: Text(
                            'newCategory'.tr(),
                            style: TextStyle(
                              color: SeedsColors.active,
                              fontSize: 24.sp,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20.h),
                            height: 55.h,
                            width: 255.w,
                            decoration: BoxDecoration(
                              color: SeedsColors.thirdColor,
                              borderRadius: BorderRadius.circular(20),
                              // 'categoryTitle'.tr(),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 12.w),
                              child: Form(
                                key: titleKey,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter a title';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: provider.categoryTitleController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'categoryTitle'.tr(),
                                      hintStyle: TextStyle(
                                          color: SeedsColors.active
                                              .withAlpha(120))),
                                  style: TextStyle(
                                    color: SeedsColors.freeStar,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Row(
                            children: [
                              Text(
                                'categoryIcon'.tr(),
                                style: TextStyle(
                                  color: SeedsColors.active.withAlpha(120),
                                  fontSize: 18.sp,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  height: 70.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    // color: SeedsColors.thirdColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: DropdownButton<String>(
                                      underline: const SizedBox(),
                                      hint: Container(
                                        decoration: BoxDecoration(
                                          // color: SeedsColors.thirdColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        height: 50.h,
                                        width: 50.w,
                                        child: Image.asset(
                                          icons.last,
                                          width: 50.w,
                                          height: 50.h,
                                        ),
                                      ),
                                      dropdownColor: SeedsColors.secondColor,
                                      menuMaxHeight: 300.h,
                                      value: provider.selectedIcon,
                                      items: categoriesIcons(),
                                      onChanged: (icon) {
                                        provider.setSelectedIcon(icon!);
                                        print(provider.selectedIcon.toString());
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 260.h),
                    child: FloatingActionButton(
                        backgroundColor: SeedsColors.thirdColor,
                        child: SvgPicture.asset('assets/icons/add.svg'),
                        onPressed: () async {
                          if (titleKey.currentState!.validate()) {
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
                            await provider.addCategory();
                            await Future.delayed(const Duration(seconds: 2));
                            AppRouter.popFromWidget();
                            AppRouter.popFromWidget();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('entertitle'.tr())));
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
