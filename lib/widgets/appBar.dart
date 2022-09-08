import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:seeds_admin/seedsColors.dart';

appBar(String title, {Color? background}) {
  return AppBar(
    elevation: 0,
    backgroundColor: background ?? SeedsColors.secondColor,
    leadingWidth: 30.w,
    leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
    title: Text(
      title,
      style: TextStyle(color: SeedsColors.freeStar, fontSize: 18.sp),
    ),
  );
}
