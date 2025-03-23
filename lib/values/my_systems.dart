import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prompts_helper/values/my_colors.dart';
import 'package:prompts_helper/values/my_styles.dart';

class MySystems {
  static showDeleteDialogs(
    BuildContext context,
    VoidCallback onYes,
    VoidCallback onCancel,
  ) {
    return showDialog(
      context: context,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.2),
      builder: (context) => IntrinsicHeight(
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MyColors.gray2,
                  borderRadius: BorderRadius.circular(24).copyWith(
                    bottomLeft: const Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Are you sure want to delete?',
                      textAlign: TextAlign.center,
                      style: MyStyles.t2.copyWith(color: MyColors.textWhite),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: onYes,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: MyColors.background,
                                borderRadius:
                                    BorderRadius.circular(16).copyWith(
                                  bottomLeft: const Radius.circular(2),
                                ),
                              ),
                              child: Text(
                                'Delete',
                                textAlign: TextAlign.center,
                                style: MyStyles.h3
                                    .copyWith(color: MyColors.textDanger),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: onCancel,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: MyColors.background,
                                borderRadius:
                                    BorderRadius.circular(16).copyWith(
                                  bottomLeft: const Radius.circular(2),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                textAlign: TextAlign.center,
                                style: MyStyles.h3
                                    .copyWith(color: MyColors.textWhite),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showWarning(String message) {
    Get.showSnackbar(GetSnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: MyColors.gray2,
      snackStyle: SnackStyle.GROUNDED,
      messageText: Text(
        message,
        style: MyStyles.t2.copyWith(color: MyColors.textWhite),
      ),
    ));
  }
}
