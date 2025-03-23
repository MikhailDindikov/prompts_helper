import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:prompts_helper/controllers/analytics_controller.dart';
import 'package:prompts_helper/ui/screens/settings_screen.dart';
import 'package:prompts_helper/values/my_colors.dart';
import 'package:prompts_helper/values/my_icons.dart';
import 'package:prompts_helper/values/my_styles.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final _controller = Get.find<AnalyticsController>();

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
          'Analytics & Insights',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: GetBuilder(
              init: _controller,
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Analytics & Insights',
                      style: MyStyles.t2.copyWith(color: MyColors.textWhite),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DataBlock(
                            title: 'Total Prompts',
                            value: _controller.promptsCnt,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: DataBlock(
                            title: 'Monthly Spending',
                            value: '\$${_controller.tracksSum}',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DataBlock(
                            title: 'Avg. Rating',
                            value: _controller.avgRate,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: DataBlock(
                            title: 'Active Services',
                            value: _controller.tracksCnt,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Prompt Performance',
                      style: MyStyles.t2.copyWith(color: MyColors.textWhite),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: MyColors.blockBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          DataRow(
                            title: 'Business Prompts',
                            value: _controller.businessPerc,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          DataRow(
                            title: 'Creative Prompts',
                            value: _controller.creativePerc,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          DataRow(
                            title: 'Code Prompts',
                            value: _controller.codePerc,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Optimization Suggestions',
                      style: MyStyles.t2.copyWith(color: MyColors.textWhite),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: MyColors.blockBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Column(
                        children: [
                          OtimizationBlock(
                            title: 'Improve Code Prompts',
                            desc:
                                'Your code prompts are performing below average. Try adding more context.',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          OtimizationBlock(
                            title: 'Optimize Subscription',
                            desc:
                                'Consider switching to annual billing for OpenAI to save 16%.',
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class DataBlock extends StatelessWidget {
  final String title;
  final String value;
  const DataBlock({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: MyColors.blockBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: MyStyles.c1.copyWith(color: MyColors.textGray),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            value,
            style: MyStyles.t2.copyWith(color: MyColors.textWhite),
          ),
        ],
      ),
    );
  }
}

class DataRow extends StatelessWidget {
  final String title;
  final int value;
  const DataRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: MyStyles.c1.copyWith(color: MyColors.textWhite),
            ),
            Text(
              '${value.round()}%',
              style: MyStyles.c2.copyWith(color: MyColors.acent),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 8,
              width: Get.width - 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: MyColors.background,
              ),
            ),
            Container(
              height: 8,
              width: (Get.width - 64) * value / 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: MyColors.acent,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class OtimizationBlock extends StatelessWidget {
  final String title;
  final String desc;

  const OtimizationBlock({super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            MyIcons.trend,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: MyStyles.t4.copyWith(
                    color: MyColors.textWhite,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  desc,
                  style: MyStyles.c2.copyWith(
                    color: MyColors.textGray,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
