import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:prompts_helper/helper.dart';
import 'package:prompts_helper/ui/screens/app_data_screen.dart';
import 'package:prompts_helper/values/my_colors.dart';
import 'package:prompts_helper/values/my_icons.dart';
import 'package:prompts_helper/values/my_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: MyStyles.h2.copyWith(
            color: MyColors.textWhite,
          ),
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
                children: [
                  SettingsCard(
                    iconPath: MyIcons.privacy,
                    title: 'Privacy Policy',
                    onTap: () {
                      Get.to(
                          () => AppDataScreen(appDataType: 'Privacy Policy'));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SettingsCard(
                    iconPath: MyIcons.privacy,
                    title: 'Terms of Use',
                    onTap: () {
                      Get.to(() => AppDataScreen(appDataType: 'Terms of Use'));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SettingsCard(
                    iconPath: MyIcons.support,
                    title: 'Support',
                    onTap: () {
                      Get.to(() => AppDataScreen(appDataType: 'Support'));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => AppHelper.isRestoreLoading.value
                        ? SettingsLoadCard(title: 'Restore Purchases')
                        : SettingsCard(
                            iconPath: MyIcons.restore,
                            title: 'Restore Purchases',
                            onTap: () {
                              AppHelper.restorePrem();
                            },
                          ),
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

class SettingsCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final void Function() onTap;
  const SettingsCard(
      {super.key,
      required this.iconPath,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          SvgPicture.asset(iconPath),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              title,
              style: MyStyles.c1.copyWith(color: MyColors.textWhite),
            ),
          ),
          SvgPicture.asset(MyIcons.next),
        ],
      ),
    );
  }
}

class SettingsLoadCard extends StatelessWidget {
  final String title;
  const SettingsLoadCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CupertinoActivityIndicator(
          color: MyColors.acent,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            title,
            style: MyStyles.c1.copyWith(color: MyColors.textWhite),
          ),
        ),
        SvgPicture.asset(MyIcons.next),
      ],
    );
  }
}
