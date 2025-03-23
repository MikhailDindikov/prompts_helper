import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prompts_helper/controllers/tracks_controller.dart';
import 'package:prompts_helper/models/tracker_model.dart';
import 'package:prompts_helper/my_notifications.dart';
import 'package:prompts_helper/values/my_colors.dart';
import 'package:prompts_helper/values/my_icons.dart';
import 'package:prompts_helper/values/my_styles.dart';
import 'package:prompts_helper/values/my_systems.dart';

class CreateNewTrackingScreen extends StatefulWidget {
  final TrackerModel? model;
  const CreateNewTrackingScreen({super.key, this.model});

  @override
  State<CreateNewTrackingScreen> createState() =>
      _CreateNewTrackingScreenState();
}

class _CreateNewTrackingScreenState extends State<CreateNewTrackingScreen> {
  late final _name = TextEditingController(text: widget.model?.title);
  late final _date = TextEditingController(
      text: widget.model == null
          ? ''
          : DateFormat('dd.MM.yyyy').format(widget.model!.startDate));
  late final _price =
      TextEditingController(text: (widget.model?.price ?? '').toString());
  late final RxInt _type = (widget.model?.type ?? 0).obs;
  final _types = ['Weekly', 'Monthly', 'Yearly'];
  late final _notificatable = (widget.model?.notificatable ?? false).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.model == null ? 'Add Service' : 'Edit Service',
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
                      'Service Name',
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
                        hintText: 'Enter service name',
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
                      height: 12,
                    ),
                    Row(
                      children: List.generate(
                        3,
                        (index) => Expanded(
                          child: Obx(
                            () => GestureDetector(
                              onTap: () {
                                _type.value = index;
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 11),
                                margin:
                                    EdgeInsets.only(right: index == 2 ? 0 : 4),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: _type.value == index
                                      ? MyColors.acent
                                      : MyColors.background,
                                ),
                                child: Text(
                                  _types[index],
                                  style: MyStyles.c1.copyWith(
                                    color: _type.value == index
                                        ? MyColors.background
                                        : MyColors.textGray,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Start Date',
                      style: MyStyles.t4.copyWith(color: MyColors.textWhite),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _date,
                      style: MyStyles.c1.copyWith(color: MyColors.textWhite),
                      inputFormatters: [DateTextFormatter()],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: MyColors.gray2,
                        hintText: 'dd.mm.yyyy',
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
                      'Price',
                      style: MyStyles.t4.copyWith(color: MyColors.textWhite),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _price,
                      style: MyStyles.c1.copyWith(color: MyColors.textWhite),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: MyColors.gray2,
                        hintText: 'Enter price \$',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Notifications',
                          style:
                              MyStyles.t4.copyWith(color: MyColors.textWhite),
                        ),
                        Obx(
                          () => CupertinoSwitch(
                            activeColor: MyColors.acent,
                            value: _notificatable.value,
                            onChanged: (val) {
                              _notificatable.value = val;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_name.text.isEmpty ||
                            _date.text.length != 10 ||
                            _price.text.isEmpty) {
                          MySystems.showWarning(
                              'Please, fill name, price and date fields!');
                        } else {
                          if (widget.model == null) {
                            Get.find<TracksController>().addTrack(TrackerModel(
                              id: UniqueKey().toString(),
                              title: _name.text,
                              type: _type.value,
                              startDate: DateTime(
                                int.parse(_date.text.split('.')[2]),
                                int.parse(_date.text.split('.')[1]),
                                int.parse(_date.text.split('.')[0]),
                              ),
                              price: int.parse(_price.text),
                              notificatable: _notificatable.value,
                            ));

                            if (_notificatable.value) {
                              MyNotifications.createScheduledNotification(
                                id: UniqueKey().hashCode,
                                title: 'Servise payment',
                                body: "Don't forget about the next payment",
                                showAt: DateTime(
                                  int.parse(_date.text.split('.')[2]) + 1,
                                  int.parse(_date.text.split('.')[1]),
                                  int.parse(_date.text.split('.')[0]),
                                ),
                              );
                            }
                          } else {
                            Get.find<TracksController>().editTrack(TrackerModel(
                              id: widget.model!.id,
                              title: _name.text,
                              type: _type.value,
                              startDate: DateTime(
                                int.parse(_date.text.split('.')[2]),
                                int.parse(_date.text.split('.')[1]),
                                int.parse(_date.text.split('.')[0]),
                              ),
                              price: int.parse(_price.text),
                              notificatable: _notificatable.value,
                            ));

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

class DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final snackbar = GetSnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: MyColors.gray2,
      snackStyle: SnackStyle.GROUNDED,
      messageText: Text(
        'Please, enter correct date!',
        style: MyStyles.t2.copyWith(color: MyColors.textWhite),
      ),
    );

    if (newValue.text.length > oldValue.text.length &&
        newValue.text.isNotEmpty &&
        oldValue.text.isNotEmpty) {
      if (RegExp('[^0-9.]').hasMatch(newValue.text)) {
        Get.showSnackbar(snackbar);
        return oldValue;
      }
      if (newValue.text.length > 10) return oldValue;
      if (newValue.text.length == 1) {
        if (newValue.text.isNum) {
          if (int.parse(newValue.text) >= 0 && int.parse(newValue.text) <= 3) {
            SnackbarController.cancelAllSnackbars();
            return newValue;
          } else {
            Get.showSnackbar(snackbar);
            return oldValue;
          }
        } else {
          Get.showSnackbar(snackbar);
          return oldValue;
        }
      } else if (newValue.text.length == 2 || newValue.text.length == 5) {
        if (_checkDate(newValue.text)) {
          return TextEditingValue(
            text: '${newValue.text}.',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        } else {
          Get.showSnackbar(snackbar);
          return oldValue;
        }
      } else if (newValue.text.length == 3) {
        if (newValue.text[2] != '.') {
          if (newValue.text.substring(2)[0] == '0' ||
              newValue.text.substring(2)[0] == '1') {
            return TextEditingValue(
              text:
                  '${newValue.text.substring(0, 2)}.${newValue.text.substring(2)}',
              selection: TextSelection.collapsed(
                offset: newValue.selection.end + 1,
              ),
            );
          } else {
            return TextEditingValue(
              text: '${newValue.text.substring(0, 2)}.',
              selection: TextSelection.collapsed(
                offset: newValue.selection.end,
              ),
            );
          }
        } else {
          SnackbarController.cancelAllSnackbars();
          return newValue;
        }
      } else if (newValue.text.length == 4) {
        if (newValue.text[newValue.text.length - 1].isNum) {
          if (newValue.text[3] == '0' || newValue.text[3] == '1') {
            SnackbarController.cancelAllSnackbars();
            return newValue;
          } else {
            Get.showSnackbar(snackbar);
            return oldValue;
          }
        } else {
          Get.showSnackbar(snackbar);
          return oldValue;
        }
      } else if (newValue.text.length == 6) {
        if (newValue.text[5] != '.') {
          if (newValue.text.substring(5) == DateTime.now().year.toString()[0]) {
            return TextEditingValue(
              text:
                  '${newValue.text.substring(0, 5)}.${newValue.text.substring(5)}',
              selection: TextSelection.collapsed(
                offset: newValue.selection.end + 1,
              ),
            );
          } else {
            return TextEditingValue(
              text: '${newValue.text.substring(0, 5)}.',
              selection: TextSelection.collapsed(
                offset: newValue.selection.end,
              ),
            );
          }
        } else {
          SnackbarController.cancelAllSnackbars();
          return newValue;
        }
      }
    }
    if (newValue.text.length == 1 && oldValue.text.isEmpty) {
      if (newValue.text.isNum) {
        if (int.parse(newValue.text) >= 0 && int.parse(newValue.text) <= 3) {
          SnackbarController.cancelAllSnackbars();
          return newValue;
        } else {
          Get.showSnackbar(snackbar);
          return oldValue;
        }
      } else {
        Get.showSnackbar(snackbar);
        return oldValue;
      }
    }

    SnackbarController.cancelAllSnackbars();
    return newValue;
  }

  bool _checkYear(String value) {
    final curYear = DateTime.now().year;
    final searchYear = int.parse(value.substring(6));
    if (searchYear <= curYear) {
      return true;
    } else {
      return false;
    }
  }

  bool _checkDate(String value) {
    if (!value[value.length - 1].isNum) {
      return false;
    }
    if (value.length == 2) {
      int day;
      if (value[0] == '0') {
        day = int.parse(value[1]);
      } else {
        day = int.parse(value);
      }

      if (day > 0 && day < 32) {
        return true;
      }

      return false;
    } else {
      final date = value.substring(3);
      int mounth;

      if (date[0] == '0') {
        mounth = int.parse(date[1]);
      } else {
        mounth = int.parse(date);
      }

      if (mounth > 0 && mounth < 13) {
        return true;
      }

      return false;
    }
  }
}
