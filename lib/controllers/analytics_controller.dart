import 'package:get/get.dart';
import 'package:prompts_helper/helper.dart';

class AnalyticsController extends GetxController {
  String promptsCnt = '0';
  String tracksCnt = '0';
  String avgRate = '0';
  String tracksSum = '0';
  int businessPerc = 0;
  int codePerc = 0;
  int creativePerc = 0;

  void loadData() {
    promptsCnt = AppHelper.getPromptsCnt();
    tracksCnt = AppHelper.getTracksCnt();
    avgRate = AppHelper.getPromptsAvgRate();
    tracksSum = AppHelper.getTracksSum();
    businessPerc = AppHelper.getPromptsBusinessPerc();
    codePerc = AppHelper.getPromptsCodePerc();
    creativePerc = AppHelper.getPromptsCreativePerc();

    update();
  }
}
