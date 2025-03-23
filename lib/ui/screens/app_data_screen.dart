import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:prompts_helper/values/my_colors.dart';
import 'package:prompts_helper/values/my_icons.dart';
import 'package:prompts_helper/values/my_styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppDataScreen extends StatefulWidget {
  final String appDataType;
  const AppDataScreen({super.key, required this.appDataType});

  @override
  State<AppDataScreen> createState() => _AppDataScreenState();
}

class _AppDataScreenState extends State<AppDataScreen> {
  late WebViewController _dataType;

  @override
  void initState() {
    String dataType = '';
    if (widget.appDataType == 'Privacy Policy') {
      dataType =
          'https://www.privacypolicies.com/live/8f15a13a-1214-4f48-9c80-646e742b9d27';
    } else if (widget.appDataType == 'Terms of Use') {
      dataType =
          'https://www.privacypolicies.com/live/35393146-54d7-4bac-8ee6-9c1dc6ea7a59';
    } else {
      dataType = 'https://form.jotform.com/250814865522459';
    }

    _dataType = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(dataType));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: Get.back,
                      child: Container(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          MyIcons.back,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.appDataType,
                      textAlign: TextAlign.center,
                      style: MyStyles.h2.copyWith(
                        color: MyColors.textWhite,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0,
                    child: IgnorePointer(
                      child: Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: Get.back,
                          child: Container(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              MyIcons.back,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: WebViewWidget(
                  controller: _dataType,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
