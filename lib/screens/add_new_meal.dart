import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';
import 'package:seeds_admin/app_router.dart';
import 'package:seeds_admin/data/seed_provider.dart';
import 'package:seeds_admin/modules/category.dart';
import 'package:seeds_admin/seedsColors.dart';
import 'package:seeds_admin/widgets/appBar.dart';
import 'package:seeds_admin/widgets/categories_list_items.dart';

class AddNewMeal extends StatelessWidget {
  List<String> days = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> mealKey = GlobalKey<FormState>();
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return Scaffold(
      backgroundColor: SeedsColors.secondColor,
      floatingActionButton: showFab
          ? InkWell(
              onTap: () async {
                if (mealKey.currentState!.validate() &&
                    Provider.of<SeedsProvider>(context, listen: false)
                            .mealImage !=
                        null) {
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
                  await Provider.of<SeedsProvider>(context, listen: false)
                      .addMeal();
                  await Future.delayed(Duration(milliseconds: 700));
                  AppRouter.popFromWidget();
                  AppRouter.popFromWidget();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text("Make sure to add an Image and fell all fields"),
                  ));
                }
              },
              child: Form(
                key: mealKey,
                child: Container(
                  decoration: BoxDecoration(
                    color: SeedsColors.active,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  width: 343.w,
                  height: 45,
                  child: Center(
                      child: Text(
                    'addNewMeal'.tr(),
                    style: TextStyle(
                      color: SeedsColors.secondColor,
                      fontSize: 18,
                    ),
                  )),
                ),
              ),
            )
          : const SizedBox(),
      appBar: appBar('addNewMeal'.tr()),
      body: Consumer<SeedsProvider>(
        builder: (BuildContext context, provider, child) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(bottom: 100.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.h),
                    child: Text(
                      'addMealImage'.tr(),
                      style: TextStyle(
                        color: SeedsColors.freeStar,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: SeedsColors.secondColor,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await provider
                                      .selectImage(ImageSource.camera);
                                  AppRouter.popFromWidget();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.r),
                                  decoration: BoxDecoration(
                                      color: SeedsColors.thirdColor,
                                      borderRadius:
                                          BorderRadius.circular(25.r)),
                                  height: 120.h,
                                  width: 100.w,
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        size: 70.r,
                                        color: SeedsColors.active,
                                      ),
                                      Text(
                                        'camera'.tr(),
                                        style: TextStyle(
                                          color: SeedsColors.freeStar,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await provider
                                      .selectImage(ImageSource.gallery);
                                  AppRouter.popFromWidget();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.r),
                                  decoration: BoxDecoration(
                                      color: SeedsColors.thirdColor,
                                      borderRadius:
                                          BorderRadius.circular(25.r)),
                                  height: 120.h,
                                  width: 100.w,
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 70.r,
                                        color: SeedsColors.active,
                                      ),
                                      Text(
                                        'gallery'.tr(),
                                        style: TextStyle(
                                          color: SeedsColors.freeStar,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      margin: EdgeInsets.all(12.h),
                      width: MediaQuery.of(context).size.width,
                      child: provider.mealImage == null
                          ? CircleAvatar(
                              backgroundColor: SeedsColors.thirdColor,
                              radius: 100.r,
                              child: SvgPicture.asset(
                                'assets/icons/add.svg',
                              ),
                            )
                          : Image.file(provider.mealImage!),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      height: 50.h,
                      width: 343.w,
                      decoration: BoxDecoration(
                        color: SeedsColors.thirdColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Enter a title';
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 18.w, vertical: 10.h),
                          hintText: "mealTitle".tr(),
                          hintStyle: TextStyle(
                            color: SeedsColors.active,
                            fontSize: 14.sp,
                          ),
                        ),
                        controller: provider.mealTitleController,
                        style: TextStyle(color: SeedsColors.freeStar),
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      height: 130.h,
                      width: 343.w,
                      decoration: BoxDecoration(
                        color: SeedsColors.thirdColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        maxLines: 30,
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Enter a description';
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 18.w, vertical: 10.h),
                          hintText: "mealdescription".tr(),
                          hintStyle: TextStyle(
                            color: SeedsColors.active,
                            fontSize: 14.sp,
                          ),
                        ),
                        controller: provider.mealDescController,
                        style: TextStyle(color: SeedsColors.freeStar),
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      height: 70.h,
                      width: 343.w,
                      decoration: BoxDecoration(
                        color: SeedsColors.thirdColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButton<Category>(
                        underline: const SizedBox(),
                        hint: provider.selectedMealCategory == null
                            ? Container(
                                decoration: BoxDecoration(
                                  color: SeedsColors.thirdColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 70.h,
                                width: 100.w,
                                child: ListTile(
                                  title: Text(
                                    'category'.tr(),
                                    style: TextStyle(
                                        color: SeedsColors.active,
                                        fontSize: 14.r),
                                  ),
                                ),
                              )
                            : DropdownMenuItem<Category>(
                                value: provider.selectedMealCategory,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: SeedsColors.thirdColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  height: 50.h,
                                  width: 300.w,
                                  child: ListTile(
                                    title: Text(
                                      provider.selectedMealCategory!.title!,
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          color: SeedsColors.freeStar),
                                    ),
                                    leading: Image.asset(provider
                                        .selectedMealCategory!.imagePath!),
                                  ),
                                ),
                              ),
                        dropdownColor: SeedsColors.secondColor,
                        menuMaxHeight: 200.h,
                        items: categoriesMenu(
                            provider.selectedMealCategory, provider.categories),
                        value: provider.selectedMealCategory,
                        onChanged: (category) {
                          provider.setSelectedCategory(category!);
                          print(provider.selectedMealCategory.toString());
                        },
                      )),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 16.w, bottom: 10.h),
                            height: 50.h,
                            width: 95.w,
                            decoration: BoxDecoration(
                              color: SeedsColors.thirdColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 40.w,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isNotEmpty) {
                                          return null;
                                        } else {
                                          return 'Enter a price';
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: '0.0',
                                          hintStyle: TextStyle(
                                            color: SeedsColors.active,
                                            fontSize: 22.sp,
                                          ),
                                          border: InputBorder.none),
                                      controller: provider.mealPriceController,
                                      style: TextStyle(
                                        color: SeedsColors.active,
                                        fontSize: 22.sp,
                                      ),
                                    ),
                                  ),
                                  SvgPicture.asset('assets/icons/shaikel.svg'),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            iconSize: 50.r,
                            onPressed: () {
                              provider.increasePrice(false);
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/addCircle.svg',
                              // height: 50.h,
                              // width: 50.w,
                            ),
                          ),
                          IconButton(
                            iconSize: 50.r,
                            onPressed: () {
                              provider.decreasePrice(false);
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/subCircle.svg',
                              // height: 50.h,
                              // width: 50.w,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 16.w),
                            child: Text(
                              'mealPrice'.tr(),
                              style: TextStyle(
                                color: SeedsColors.freeStar,
                                fontSize: 18.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.w),
                            child: Theme(
                                data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.white,
                                    primaryColor: SeedsColors.active),
                                child: Checkbox(
                                  onChanged: (value) {
                                    provider.setPopular();
                                  },
                                  value: provider.isPopularMeal,
                                  checkColor: SeedsColors.freeStar,
                                )),
                          ),
                          Text(
                            'popularMeal'.tr(),
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: SeedsColors.freeStar,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.w),
                            child: Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.white,
                                ),
                                child: Checkbox(
                                  onChanged: (value) {
                                    provider.addSalePrice();
                                  },
                                  value: provider.hasSale,
                                  checkColor: SeedsColors.freeStar,
                                )),
                          ),
                          Text(
                            'addSalePrice'.tr(),
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: SeedsColors.freeStar,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  provider.hasSale
                      ? Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10.h),
                              // height: 50.h,
                              width: 343.w,
                              decoration: BoxDecoration(
                                color: SeedsColors.thirdColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: MultiSelectDialogField(
                                confirmText: Text(
                                  'ok'.tr(),
                                  style: TextStyle(color: SeedsColors.freeStar),
                                ),
                                cancelText: Text(
                                  'cancel'.tr(),
                                  style: TextStyle(color: SeedsColors.freeStar),
                                ),
                                backgroundColor: SeedsColors.secondColor,
                                buttonIcon: Icon(
                                  Icons.arrow_drop_down,
                                  color: SeedsColors.active,
                                  size: 30.r,
                                ),
                                buttonText: Text(
                                  'saleDays'.tr(),
                                  style: TextStyle(
                                      color: SeedsColors.active,
                                      fontSize: 18.sp),
                                ),
                                title: Text(
                                  'saleDays'.tr(),
                                  style: TextStyle(color: SeedsColors.active),
                                ),
                                items: days
                                    .map((e) => MultiSelectItem(e, e))
                                    .toList(),
                                listType: MultiSelectListType.CHIP,
                                decoration: const BoxDecoration(border: null),
                                onConfirm: (values) {
                                  provider.selectedDays = values.toString();
                                },
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 16.w, bottom: 10.h),
                                  height: 50.h,
                                  width: 95.w,
                                  decoration: BoxDecoration(
                                    color: SeedsColors.thirdColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: 40.w,
                                          child: TextFormField(
                                            validator: (value) {
                                              if (provider.hasSale &&
                                                  value!.isEmpty) {
                                                return 'Enter a sale price';
                                              } else {
                                                return null;
                                              }
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                hintText: '0.0',
                                                hintStyle: TextStyle(
                                                  color: SeedsColors.active,
                                                  fontSize: 22.sp,
                                                ),
                                                border: InputBorder.none),
                                            controller: provider
                                                .mealPriceInSaleController,
                                            style: TextStyle(
                                              color: SeedsColors.active,
                                              fontSize: 22.sp,
                                            ),
                                          ),
                                        ),
                                        SvgPicture.asset(
                                            'assets/icons/shaikel.svg'),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                  iconSize: 50.r,
                                  onPressed: () {
                                    provider.increasePrice(true);
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/icons/addCircle.svg',
                                    // height: 50.h,
                                    // width: 50.w,
                                  ),
                                ),
                                IconButton(
                                  iconSize: 50.r,
                                  onPressed: () {
                                    provider.decreasePrice(true);
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/icons/subCircle.svg',
                                    // height: 50.h,
                                    // width: 50.w,
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(right: 16.w),
                                  child: Text(
                                    'mealPrice'.tr(),
                                    style: TextStyle(
                                      color: SeedsColors.freeStar,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
