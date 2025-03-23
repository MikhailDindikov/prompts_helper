import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:prompts_helper/controllers/home_controller.dart';
import 'package:prompts_helper/models/prompt_model.dart';
import 'package:prompts_helper/ui/screens/create_new_prompt_screen.dart';
import 'package:prompts_helper/values/my_colors.dart';
import 'package:prompts_helper/values/my_icons.dart';
import 'package:prompts_helper/values/my_styles.dart';
import 'package:prompts_helper/values/my_systems.dart';

class DetailPromptScreen extends StatelessWidget {
  final PromptModel model;
  const DetailPromptScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          model.name,
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
                          model.name,
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
                              Get.find<HomeController>().deletePrompt(model);
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
                            Get.to(() => CreateNewPromptScreen(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: MyColors.background,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          model.type,
                          style: MyStyles.c2.copyWith(color: MyColors.textGray),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            model.rating.toString(),
                            style:
                                MyStyles.t4.copyWith(color: MyColors.textWhite),
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
                    height: 16,
                  ),
                  Text(
                    model.text,
                    style: MyStyles.c1.copyWith(color: MyColors.textWhite),
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
