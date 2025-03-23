import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:prompts_helper/controllers/home_controller.dart';
import 'package:prompts_helper/controllers/prompts_controller.dart';
import 'package:prompts_helper/helper.dart';
import 'package:prompts_helper/models/prompt_model.dart';
import 'package:prompts_helper/ui/screens/create_new_prompt_screen.dart';
import 'package:prompts_helper/ui/screens/prompts_screen/detail_prompt.dart';
import 'package:prompts_helper/ui/screens/settings_screen.dart';
import 'package:prompts_helper/values/my_colors.dart';
import 'package:prompts_helper/values/my_icons.dart';
import 'package:prompts_helper/values/my_styles.dart';
import 'package:prompts_helper/values/my_systems.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = Get.find<HomeController>();

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
          'Dashboard',
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
          child: Column(
            children: [
              Row(
                children: [
                  // Expanded(
                  //   child: Container(
                  //     height: 68,
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //       color: MyColors.blockBackground,
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         SvgPicture.asset(
                  //           MyIcons.analyzePrompt,
                  //         ),
                  //         const SizedBox(
                  //           height: 4,
                  //         ),
                  //         Text(
                  //           'Analyze Prompts',
                  //           style:
                  //               MyStyles.c1.copyWith(color: MyColors.textWhite),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 16,
                  // ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (!AppHelper.isPremium.value &&
                            Get.find<PromptsController>().data.length == 15) {
                          MySystems.showWarning(
                              'Please buy premium to create more prompts!');
                        } else {
                          Get.to(() => const CreateNewPromptScreen());
                        }
                      },
                      child: Container(
                        height: 68,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: MyColors.blockBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              MyIcons.createPrompt,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Create New Prompt',
                              style: MyStyles.c1
                                  .copyWith(color: MyColors.textWhite),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              GetBuilder(
                  init: _controller,
                  builder: (_) {
                    if (_controller.data.isEmpty) {
                      return const EmptyCard();
                    } else {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, ind) =>
                            BlockBody(model: _controller.data[ind]),
                        separatorBuilder: (ctx, ind) => const SizedBox(
                          height: 24,
                        ),
                        itemCount: _controller.data.length,
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class BlockBody extends StatelessWidget {
  final PromptBlockModel model;
  const BlockBody({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.type,
          style: MyStyles.t2.copyWith(
            color: MyColors.textWhite,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (ctx, ind) => BlockCard(
            model: model.prompts[ind],
          ),
          separatorBuilder: (ctx, ind) => const SizedBox(
            height: 16,
          ),
          itemCount: model.prompts.length,
        ),
      ],
    );
  }
}

class BlockCard extends StatelessWidget {
  final PromptModel model;
  const BlockCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailPromptScreen(
              model: model,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: MyColors.blockBackground,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    model.name,
                    style: MyStyles.t4.copyWith(color: MyColors.textWhite),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      model.rating.toString(),
                      style: MyStyles.t4.copyWith(color: MyColors.textWhite),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset(MyIcons.starSmall)
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: MyColors.background,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                model.type,
                style: MyStyles.c2.copyWith(color: MyColors.textGray),
              ),
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
            'Create Your First Prompt',
            textAlign: TextAlign.center,
            style: MyStyles.t2.copyWith(color: MyColors.textWhite),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Start by creating a prompt for your AI assistant. You can organize them into categories and track their performance.',
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
