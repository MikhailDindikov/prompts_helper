import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prompts_helper/controllers/my_bindings.dart';
import 'package:prompts_helper/helper.dart';
import 'package:prompts_helper/my_notifications.dart';
import 'package:prompts_helper/ui/screens/app_screen.dart';
import 'package:prompts_helper/ui/screens/tutorial_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppHelper.loadData();

  final hasTutororialShown =
      AppHelper.prefs.getBool('hasTutororialShown') ?? false;
  runApp(PromptsApp(
    showTutorial: !hasTutororialShown,
  ));
}

class PromptsApp extends StatefulWidget {
  final bool showTutorial;
  const PromptsApp({super.key, required this.showTutorial});

  @override
  State<PromptsApp> createState() => _PromptsAppState();
}

class _PromptsAppState extends State<PromptsApp> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    //MyNotifications.requestPermissions();
    MyNotifications.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MyBindings(),
      title: 'The Prompts Helper',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: 'SFProText',
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
          )),
      home: widget.showTutorial ? const TutorialScreen() : const AppScreen(),
    );
  }
}
