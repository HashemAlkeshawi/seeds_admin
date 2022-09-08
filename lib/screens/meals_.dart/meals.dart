import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:seeds_admin/data/seed_provider.dart';
import 'package:seeds_admin/modules/category.dart';
import 'package:seeds_admin/modules/meal.dart';
import 'package:seeds_admin/screens/meals_.dart/mealInfo.dart';
import 'package:seeds_admin/seedsColors.dart';
import 'package:seeds_admin/widgets/appBar.dart';
import 'package:seeds_admin/widgets/mealWidget.dart';

class Meals extends StatelessWidget {
  Category category;
  Meals(this.category);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SeedsColors.secondColor,
      appBar: appBar(category.title!),
      body: Consumer<SeedsProvider>(
        builder: (BuildContext context, provider, child) {
          List<Meal> meals = provider.meals;
          return Container(
            color: SeedsColors.secondColor,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
              ),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return mealInfo(context, provider, meals[index]);
                        },
                        context: context);
                  },
                  child: mealWidget(context, meals[index], provider),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
