import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:prompts_helper/helper.dart';
import 'package:prompts_helper/ui/screens/settings_screen.dart';
import 'package:prompts_helper/values/my_colors.dart';
import 'package:prompts_helper/values/my_icons.dart';
import 'package:prompts_helper/values/my_styles.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Premium',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            children: [
              SvgPicture.asset(MyIcons.premLabel),
              const SizedBox(
                height: 32,
              ),
              Text(
                'Premium Features',
                style: MyStyles.h2.copyWith(color: MyColors.textWhite),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'One-time purchase, lifetime access',
                style: MyStyles.c1.copyWith(color: MyColors.textGray),
              ),
              const SizedBox(
                height: 24,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: MyColors.blockBackground,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                        text: '\$00.99',
                                        style: MyStyles.h1.copyWith(
                                          color: MyColors.acent,
                                        )),
                                    TextSpan(
                                        text: ' one-time',
                                        style: MyStyles.c2.copyWith(
                                          color: MyColors.textGray,
                                        )),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              // Row(
                              //   children: [
                              //     SvgPicture.asset(MyIcons.checkup),
                              //     const SizedBox(
                              //       width: 8,
                              //     ),
                              //     Expanded(
                              //       child: Text(
                              //         'Advanced analytics and insights',
                              //         style: MyStyles.c1
                              //             .copyWith(color: MyColors.textWhite),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 16,
                              // ),
                              Row(
                                children: [
                                  SvgPicture.asset(MyIcons.checkup),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Unlimited prompt storage',
                                      style: MyStyles.c1
                                          .copyWith(color: MyColors.textWhite),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              // Row(
                              //   children: [
                              //     SvgPicture.asset(MyIcons.checkup),
                              //     const SizedBox(
                              //       width: 8,
                              //     ),
                              //     Expanded(
                              //       child: Text(
                              //         'Custom categories and tags',
                              //         style: MyStyles.c1
                              //             .copyWith(color: MyColors.textWhite),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 16,
                              // ),
                              // Row(
                              //   children: [
                              //     SvgPicture.asset(MyIcons.checkup),
                              //     const SizedBox(
                              //       width: 8,
                              //     ),
                              //     Expanded(
                              //       child: Text(
                              //         'Priority support',
                              //         style: MyStyles.c1
                              //             .copyWith(color: MyColors.textWhite),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 16,
                              // ),
                              // Row(
                              //   children: [
                              //     SvgPicture.asset(MyIcons.checkup),
                              //     const SizedBox(
                              //       width: 8,
                              //     ),
                              //     Expanded(
                              //       child: Text(
                              //         'Export and import prompts',
                              //         style: MyStyles.c1
                              //             .copyWith(color: MyColors.textWhite),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 16,
                              // ),
                              Row(
                                children: [
                                  SvgPicture.asset(MyIcons.checkup),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'No advertisements',
                                      style: MyStyles.c1
                                          .copyWith(color: MyColors.textWhite),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  if (!AppHelper.isPremium.value &&
                      !AppHelper.isPremiumLoading.value) {
                    AppHelper.buyPrem();
                  }
                },
                child: Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: MyColors.acent,
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  child: Obx(
                    () => AppHelper.isPremiumLoading.value
                        ? CupertinoActivityIndicator(
                            color: MyColors.background,
                          )
                        : Text(
                            AppHelper.isPremium.value
                                ? 'Activated'
                                : 'Upgrade Now',
                            style: MyStyles.t2
                                .copyWith(color: MyColors.background),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
