import 'package:get/get.dart';
import 'package:prompts_helper/controllers/analytics_controller.dart';
import 'package:prompts_helper/controllers/prompts_controller.dart';
import 'package:prompts_helper/helper.dart';
import 'package:prompts_helper/models/prompt_model.dart';

class HomeController extends GetxController {
  List<PromptBlockModel> data = [];
  List<PromptModel> topViewed = [];
  List<PromptModel> topRated = [];

  void loadData() {
    topRated = AppHelper.getTopRatedBlocks();
    topViewed = AppHelper.getTopViewedBlocks();
    data.clear();
    if (topViewed.isNotEmpty) {
      data.add(PromptBlockModel(type: 'Recently Used', prompts: topViewed));
    }
    if (topRated.isNotEmpty) {
      data.add(PromptBlockModel(type: 'Top Rated', prompts: topRated));
    }

    update();
  }

  void reloadAll() {
    loadData();
    Get.find<PromptsController>().loadData();
    Get.find<AnalyticsController>().loadData();
  }

  Future<void> deletePrompt(PromptModel model) async {
    await AppHelper.deletePrompt(model);
    reloadAll();
  }

  Future<void> addPrompt(PromptModel model) async {
    await AppHelper.addPrompt(model);
    reloadAll();
  }

  Future<void> editPrompt(PromptModel model) async {
    await AppHelper.editPrompt(model);
    reloadAll();
  }
}
