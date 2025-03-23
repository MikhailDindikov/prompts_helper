import 'package:get/get.dart';
import 'package:prompts_helper/controllers/analytics_controller.dart';
import 'package:prompts_helper/helper.dart';
import 'package:prompts_helper/models/tracker_model.dart';

class TracksController extends GetxController {
  List<TrackerModel> trackers = [];

  void loadData() {
    trackers = AppHelper.getAllTracks();

    update();
  }

  void reloadAll() {
    loadData();
    Get.find<AnalyticsController>().loadData();
  }

  Future<void> deleteTrack(TrackerModel model) async {
    await AppHelper.deleteTrack(model);
    reloadAll();
  }

  Future<void> addTrack(TrackerModel model) async {
    await AppHelper.addTrack(model);
    reloadAll();
  }

  Future<void> editTrack(TrackerModel model) async {
    await AppHelper.editTrack(model);
    reloadAll();
  }
}
