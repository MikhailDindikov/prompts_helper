import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prompts_helper/controllers/tracks_controller.dart';
import 'package:prompts_helper/models/tracker_model.dart';
import 'package:prompts_helper/ui/screens/create_new_tracking.dart';
import 'package:prompts_helper/values/my_colors.dart';
import 'package:prompts_helper/values/my_icons.dart';
import 'package:prompts_helper/values/my_styles.dart';
import 'package:prompts_helper/values/my_systems.dart';

class DetailTrackingScreen extends StatelessWidget {
  final TrackerModel model;
  const DetailTrackingScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          model.title,
          style: MyStyles.h2.copyWith(
            color: MyColors.textWhite,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            height: 24,
            alignment: Alignment.center,
            child: SvgPicture.asset(MyIcons.back),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 16,
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MyColors.blockBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '\$${model.price}',
                          style:
                              MyStyles.t4.copyWith(color: MyColors.textWhite),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            MySystems.showDeleteDialogs(context, () {
                              Get.find<TracksController>().deleteTrack(model);
                              Get.back();
                              Get.back();
                            }, () {
                              Get.back();
                            });
                          },
                          child: SvgPicture.asset(MyIcons.delete)),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Get.to(() => CreateNewTrackingScreen(
                                  model: model,
                                ));
                          },
                          child: SvgPicture.asset(MyIcons.edit))
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              MyIcons.calendar,
                              height: 16,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Renews: ${model.calculateNextPaymentDate()}',
                                style: MyStyles.c2
                                    .copyWith(color: MyColors.textGray),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SvgPicture.asset(
                        MyIcons.notification,
                        color: model.notificatable ? MyColors.acent : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
