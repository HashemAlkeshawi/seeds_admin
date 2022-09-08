import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seeds_admin/modules/category.dart';

import '../seedsColors.dart';

List<DropdownMenuItem<Category>> categoriesMenu(
    Category? selectedCategory, List<Category> categories) {
  // (selectedCategory != null)
  //     ? categories.removeWhere((element) => element.id == selectedCategory.id)
  //     : print('');
  List<DropdownMenuItem<Category>> categoriesMenu = categories.map((e) {
    return DropdownMenuItem<Category>(
      value: e,
      child: Container(
        decoration: BoxDecoration(
          color: SeedsColors.thirdColor,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 50.h,
        width: 300.w,
        child: ListTile(
          title: Text(
            e.title!,
            style: TextStyle(fontSize: 18.sp, color: SeedsColors.freeStar),
          ),
          leading: Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: Image.asset(
              e.imagePath!,
              height: 35.h,
            ),
          ),
        ),
      ),
    );
  }).toList();

  return categoriesMenu;
}

List<String> icons = [
  'assets/icons/categories/appetizers.png',
  'assets/icons/categories/barbecue.png',
  'assets/icons/categories/beef.png',
  'assets/icons/categories/burgar.png',
  'assets/icons/categories/cheese.png',
  'assets/icons/categories/cheesecaccke.png',
  'assets/icons/categories/chicken-leg.png',
  'assets/icons/categories/chrimp.png',
  'assets/icons/categories/cockies.png',
  'assets/icons/categories/doughnut.png',
  'assets/icons/categories/fried-chicken.png',
  'assets/icons/categories/fried-fish.png',
  'assets/icons/categories/frinshFrise.png',
  'assets/icons/categories/grilled_fish.png',
  'assets/icons/categories/icecreem.png',
  'assets/icons/categories/kebab.png',
  'assets/icons/categories/lemonade.png',
  'assets/icons/categories/pizza.png',
  'assets/icons/categories/pizza_.png',
  'assets/icons/categories/sandwich.png',
  'assets/icons/categories/sausage.png',
  'assets/icons/categories/soup1.png',
  'assets/icons/categories/spaghetti.png',
  'assets/icons/categories/steack.png',
  'assets/icons/categories/steak.png',
  'assets/icons/categories/sushi.png',
  'assets/icons/categories/turcky.png',
  'assets/icons/categories/feather.png',
];

List<DropdownMenuItem<String>> categoriesIcons() {
  List<DropdownMenuItem<String>> categoriesMenu = icons.map((e) {
    return DropdownMenuItem<String>(
      value: e,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          height: 50.h,
          width: 50.w,
          child: Image.asset(e)),
    );
  }).toList();

  return categoriesMenu;
}
