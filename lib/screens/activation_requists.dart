import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:seeds_admin/data/seed_provider.dart';
import 'package:seeds_admin/seedsColors.dart';
import 'package:seeds_admin/widgets/appBar.dart';
import 'package:seeds_admin/widgets/activation_widget.dart';

class ActivationRequists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SeedsProvider>(
      builder: (BuildContext context, provider, child) {
        return Scaffold(
          appBar: appBar('activationRequists'.tr(),
              background: SeedsColors.secondColor),
          body: Container(
            color: SeedsColors.secondColor,
            height: MediaQuery.of(context).size.height,
            child: provider.customers.isEmpty
                ? Center(
                    child: SizedBox(
                        height: 300.h,
                        width: 300.h,
                        child: Lottie.asset('assets/animation/indecator.json')),
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      return provider.getActivationRequists();
                    },
                    child: ListView.builder(
                      reverse: true,
                      itemCount: provider.customers.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return activationWidget(
                            context, provider.customers[index], provider);
                      },
                    ),
                  ),
          ),
        );
      },
    );
  }
}
