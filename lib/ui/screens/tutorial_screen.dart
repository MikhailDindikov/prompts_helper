import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:prompts_helper/helper.dart';
import 'package:prompts_helper/ui/screens/app_screen.dart';
import 'package:prompts_helper/values/my_colors.dart';
import 'package:prompts_helper/values/my_icons.dart';
import 'package:prompts_helper/values/my_styles.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final _screenInd = 0.obs;
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      if (_screenInd.value != _pageController.page!.round()) {
        _screenInd.value = _pageController.page!.round();
      }
    });
  }

  Widget _nextButton() {
    return GestureDetector(
      onTap: () {
        if (_screenInd.value != 4) {
          _pageController.jumpToPage(_screenInd.value + 1);
        } else {
          AppHelper.prefs.setBool('hasTutororialShown', true);
          Get.offAll(() => const AppScreen());
        }
      },
      child: Container(
        height: 52,
        width: Get.width - 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColors.acent,
        ),
        child: Obx(
          () => _screenInd.value == 4
              ? Text(
                  'Get Started',
                  style: MyStyles.t2.copyWith(
                    color: MyColors.background,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: MyStyles.t2.copyWith(
                        color: MyColors.background,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SvgPicture.asset(
                      MyIcons.next,
                      color: MyColors.background,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  String _title(int index) {
    switch (index) {
      case 0:
        return 'Welcome to The Prompts Helper!';
      case 1:
        return 'Create & Organize Prompts';
      case 2:
        return 'Track Subscriptions & Expenses';
      case 3:
        return 'Analyze & Optimize';
      case 4:
        return "You're all set!";
      default:
        return '';
    }
  }

  String _imgPaths(int index) {
    switch (index) {
      case 0:
        return MyIcons.o1;
      case 1:
        return MyIcons.o2;
      case 2:
        return MyIcons.o3;
      case 3:
        return MyIcons.o4;
      case 4:
        return MyIcons.o5;
      default:
        return '';
    }
  }

  String _descr(int index) {
    switch (index) {
      case 0:
        return 'Your ultimate tool for efficiently managing AI prompts.';
      case 1:
        return 'Easily create, edit, and categorize prompts for business, creativity, coding, and more.';
      case 2:
        return 'Stay on top of your AI service subscriptions, receive renewal reminders, and manage expenses effortlessly.';
      case 3:
        return 'Discover which prompts work best with built-in analytics and AI usage insights.';
      case 4:
        return 'Start optimizing your AI interactions now.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 52,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => Obx(
                        () => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          height: 4,
                          width: 32,
                          decoration: BoxDecoration(
                            color: _screenInd >= index
                                ? MyColors.acent
                                : MyColors.blockBackground,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        _imgPaths(index),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        _title(index),
                        textAlign: TextAlign.center,
                        style: MyStyles.h2.copyWith(
                          color: MyColors.textWhite,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        _descr(index),
                        textAlign: TextAlign.center,
                        style: MyStyles.c1.copyWith(
                          color: MyColors.textGray,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 50,
                  child: _nextButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
