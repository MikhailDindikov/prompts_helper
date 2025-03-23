import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:prompts_helper/controllers/home_controller.dart';
import 'package:prompts_helper/models/prompt_model.dart';
import 'package:prompts_helper/values/my_colors.dart';
import 'package:prompts_helper/values/my_icons.dart';
import 'package:prompts_helper/values/my_styles.dart';
import 'package:prompts_helper/values/my_systems.dart';

class CreateNewPromptScreen extends StatefulWidget {
  final PromptModel? model;
  const CreateNewPromptScreen({super.key, this.model});

  @override
  State<CreateNewPromptScreen> createState() => _CreateNewPromptScreenState();
}

class _CreateNewPromptScreenState extends State<CreateNewPromptScreen> {
  late final _name = TextEditingController(text: widget.model?.name);
  late final _text = TextEditingController(text: widget.model?.text);
  late final _rating = (widget.model?.rating ?? 0).obs;
  final _ctr = ExpandableController();
  late final _curType = (widget.model?.type ?? 'Business').obs;

  final _types = [
    'Business',
    'Code',
    'Creative',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.model == null ? 'Create Prompt' : 'Edit Prompt',
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
        child: SingleChildScrollView(
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
                    Text(
                      'Prompt name',
                      style: MyStyles.t4.copyWith(color: MyColors.textWhite),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _name,
                      style: MyStyles.c1.copyWith(color: MyColors.textWhite),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: MyColors.gray2,
                        hintText: 'Enter promt name',
                        hintStyle:
                            MyStyles.c1.copyWith(color: MyColors.textGray),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Text Prompt',
                      style: MyStyles.t4.copyWith(color: MyColors.textWhite),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _text,
                      style: MyStyles.c1.copyWith(color: MyColors.textWhite),
                      minLines: 5,
                      maxLines: 5,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: MyColors.gray2,
                        hintText: 'Enter promt text',
                        hintStyle:
                            MyStyles.c1.copyWith(color: MyColors.textGray),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Rating',
                      style: MyStyles.t4.copyWith(color: MyColors.textWhite),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 11.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColors.gray2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          5,
                          (index) => GestureDetector(
                            onTap: () {
                              _rating.value = index + 1;
                            },
                            child: Obx(
                              () => SvgPicture.asset(
                                index + 1 <= _rating.value
                                    ? MyIcons.star
                                    : MyIcons.starEmpty,
                              ),
                            ),
                          ),
                        )..reversed,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(MyIcons.type),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Type',
                          style:
                              MyStyles.t4.copyWith(color: MyColors.textWhite),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12)
                          .copyWith(right: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColors.gray2,
                      ),
                      child: ExpandableNotifier(
                        controller: _ctr,
                        child: Expandable(
                          collapsed: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              _ctr.toggle();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => Text(
                                    _curType.value,
                                    style: MyStyles.c1
                                        .copyWith(color: MyColors.textGray),
                                  ),
                                ),
                                SvgPicture.asset(MyIcons.bottom),
                              ],
                            ),
                          ),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  _ctr.toggle();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(
                                      () => Text(
                                        _curType.value,
                                        style: MyStyles.c1
                                            .copyWith(color: MyColors.textGray),
                                      ),
                                    ),
                                    RotatedBox(
                                        quarterTurns: 2,
                                        child:
                                            SvgPicture.asset(MyIcons.bottom)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: MyColors.gray2,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              ...List<Widget>.generate(
                                3,
                                (index) => GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    _curType.value = _types[index];
                                    _ctr.toggle();
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Obx(
                                      () => Text(
                                        _types[index],
                                        style: MyStyles.c1.copyWith(
                                            color:
                                                _types[index] == _curType.value
                                                    ? MyColors.acent
                                                    : MyColors.textGray),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_name.text.isEmpty || _text.text.isEmpty) {
                          MySystems.showWarning(
                              'Please, fill name and prompt fields!');
                        } else {
                          if (widget.model == null) {
                            Get.find<HomeController>().addPrompt(
                              PromptModel(
                                id: UniqueKey().toString(),
                                name: _name.text,
                                text: _text.text,
                                rating: _rating.value,
                                viewedCnt: 0,
                                type: _curType.value,
                              ),
                            );
                          } else {
                            Get.find<HomeController>().editPrompt(
                              PromptModel(
                                id: widget.model!.id,
                                name: _name.text,
                                text: _text.text,
                                rating: _rating.value,
                                viewedCnt: 0,
                                type: _curType.value,
                              ),
                            );
                            Get.back();
                          }
                          Get.back();
                        }
                      },
                      child: Container(
                        height: 52,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: MyColors.acent,
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        child: Text(
                          'Save',
                          style:
                              MyStyles.t2.copyWith(color: MyColors.background),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
