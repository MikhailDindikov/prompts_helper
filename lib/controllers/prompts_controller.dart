import 'package:get/get.dart';
import 'package:prompts_helper/helper.dart';
import 'package:prompts_helper/models/prompt_model.dart';

class PromptsController extends GetxController {
  List<PromptBlockModel> data = [];

  void loadData() {
    data = AppHelper.getPromptBlocks();

    update();
  }

  
}
