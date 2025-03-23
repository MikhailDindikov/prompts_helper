import 'package:get/get.dart';
import 'package:prompts_helper/controllers/analytics_controller.dart';
import 'package:prompts_helper/controllers/home_controller.dart';
import 'package:prompts_helper/controllers/prompts_controller.dart';
import 'package:prompts_helper/controllers/tracks_controller.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(PromptsController());
    Get.put(TracksController());
    Get.put(AnalyticsController());
  }
}
