import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:prompts_helper/ui/screens/analytics_screen.dart';
import 'package:prompts_helper/ui/screens/home_screen/home_screen.dart';
import 'package:prompts_helper/ui/screens/premium_screen.dart';
import 'package:prompts_helper/ui/screens/prompts_screen/prompts_screen.dart';
import 'package:prompts_helper/ui/screens/subscription_tracking_screen/subscription_tracking_screen.dart';
import 'package:prompts_helper/values/my_colors.dart';
import 'package:prompts_helper/values/my_icons.dart';
import 'package:prompts_helper/values/my_styles.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final RxInt _screen = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: Obx(
        () => IndexedStack(
          index: _screen.value,
          children: const [
            HomeScreen(),
            PromptsScreen(),
            SubscriptionTrackingScreen(),
            AnalyticsScreen(),
            PremiumScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            _screen.value = value;
          },
          currentIndex: _screen.value,
          backgroundColor: MyColors.blockBackground,
          selectedItemColor: MyColors.acent,
          unselectedItemColor: MyColors.textWhite,
          selectedLabelStyle: MyStyles.c3.copyWith(color: MyColors.acent),
          unselectedLabelStyle: MyStyles.c3.copyWith(color: MyColors.textWhite),
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: SvgPicture.asset(
                MyIcons.home,
              ),
              activeIcon: SvgPicture.asset(
                MyIcons.home,
                color: MyColors.acent,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Prompts',
              icon: SvgPicture.asset(
                MyIcons.prompts,
              ),
              activeIcon: SvgPicture.asset(
                MyIcons.prompts,
                color: MyColors.acent,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Subs',
              icon: SvgPicture.asset(
                MyIcons.subs,
              ),
              activeIcon: SvgPicture.asset(
                MyIcons.subs,
                color: MyColors.acent,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Analytics',
              icon: SvgPicture.asset(
                MyIcons.analytics,
              ),
              activeIcon: SvgPicture.asset(
                MyIcons.analytics,
                color: MyColors.acent,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Premium',
              icon: SvgPicture.asset(
                MyIcons.premium,
              ),
              activeIcon: SvgPicture.asset(
                MyIcons.premium,
                color: MyColors.acent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
