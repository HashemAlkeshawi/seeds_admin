import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:seeds_admin/data/seed_provider.dart';
import 'package:seeds_admin/modules/customer.dart';
import 'package:seeds_admin/modules/reservation.dart';
import 'package:seeds_admin/seedsColors.dart';
import 'package:seeds_admin/widgets/appBar.dart';
import 'package:seeds_admin/widgets/activation_widget.dart';
import 'package:seeds_admin/widgets/reservatoin_widget.dart';

class ReservationRequists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SeedsProvider>(
      builder: (BuildContext context, provider, child) {
        return Scaffold(
          appBar: appBar('reservationRequists'.tr(),
              background: SeedsColors.secondColor),
          body: Container(
            color: SeedsColors.secondColor,
            height: MediaQuery.of(context).size.height,
            child: provider.reservtionRequists.isEmpty
                ? Center(
                    child: SizedBox(
                        height: 300.h,
                        width: 300.h,
                        child: Lottie.asset('assets/animation/indecator.json')),
                  )
                : ListView.builder(
                    reverse: true,
                    itemCount: provider.reservtionRequists.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return reservationWidget(context,
                          provider.reservtionRequists[index], provider);
                    },
                  ),
          ),
        );
      },
    );
  }
}
