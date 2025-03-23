import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:prompts_helper/controllers/tracks_controller.dart';
import 'package:prompts_helper/models/tracker_model.dart';
import 'package:prompts_helper/ui/screens/create_new_tracking.dart';
import 'package:prompts_helper/ui/screens/settings_screen.dart';
import 'package:prompts_helper/ui/screens/subscription_tracking_screen/detail_tracking.dart';
import 'package:prompts_helper/values/my_colors.dart';
import 'package:prompts_helper/values/my_icons.dart';
import 'package:prompts_helper/values/my_styles.dart';
import 'package:intl/intl.dart';

class SubscriptionTrackingScreen extends StatefulWidget {
  const SubscriptionTrackingScreen({super.key});

  @override
  State<SubscriptionTrackingScreen> createState() =>
      _SubscriptionTrackingScreenState();
}

class _SubscriptionTrackingScreenState
    extends State<SubscriptionTrackingScreen> {
  final _controller = Get.find<TracksController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Subscription Tracking',
          style: MyStyles.h2.copyWith(
            color: MyColors.textWhite,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => const SettingsScreen());
            },
            child: Image.asset(
              MyIcons.settings,
              height: 24,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: Get.height,
              child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ).copyWith(bottom: 32 + 52),
                  child: GetBuilder(
                      init: _controller,
                      builder: (_) {
                        return _controller.trackers.isEmpty
                            ? const EmptyCard()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Subscription Tracker',
                                    style: MyStyles.t2
                                        .copyWith(color: MyColors.textWhite),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (ctx, ind) => TrackingCard(
                                        model: _controller.trackers[ind]),
                                    separatorBuilder: (ctx, ind) =>
                                        const SizedBox(
                                      height: 24,
                                    ),
                                    itemCount: _controller.trackers.length,
                                  ),
                                ],
                              );
                      })),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const CreateNewTrackingScreen());
              },
              child: Container(
                height: 52,
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: MyColors.acent,
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.center,
                child: Text(
                  'Add New Service',
                  style: MyStyles.t2.copyWith(color: MyColors.background),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrackingCard extends StatelessWidget {
  final TrackerModel model;
  const TrackingCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailTrackingScreen(
              model: model,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: MyColors.blockBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style:
                              MyStyles.t4.copyWith(color: MyColors.textWhite),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Plus',
                          style: MyStyles.c1.copyWith(color: MyColors.textGray),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${model.price}',
                        style: MyStyles.t4.copyWith(color: MyColors.textWhite),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        model.typeVal,
                        style: MyStyles.c1.copyWith(color: MyColors.textGray),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 28,
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
                          style: MyStyles.c2.copyWith(color: MyColors.textGray),
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
    );
  }
}

class EmptyCard extends StatefulWidget {
  const EmptyCard({super.key});

  @override
  State<EmptyCard> createState() => _EmptyCardState();
}

class _EmptyCardState extends State<EmptyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 351,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: MyColors.blockBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(MyIcons.empty),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Add Your First Service',
            textAlign: TextAlign.center,
            style: MyStyles.t2.copyWith(color: MyColors.textWhite),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Add your first service to get started and streamline your workflow!',
            style: MyStyles.c1.copyWith(
              color: MyColors.textGray,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
