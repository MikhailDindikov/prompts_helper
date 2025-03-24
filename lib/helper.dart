import 'dart:convert';

import 'package:apphud/apphud.dart';
import 'package:get/get.dart';
import 'package:prompts_helper/models/prompt_model.dart';
import 'package:prompts_helper/models/tracker_model.dart';
import 'package:prompts_helper/values/my_systems.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppHelper {
  static late final SharedPreferences prefs;
  static late RxBool isPremium;
  static RxBool isPremiumLoading = false.obs;
  static RxBool isRestoreLoading = false.obs;

  static Future<void> loadData() async {
    await Apphud.start(apiKey: 'app_fNF6mvrFjsWJXE4R6p4Q1mZWdcCVmK');
    prefs = await SharedPreferences.getInstance();
    isPremium = (prefs.getBool('isPremium') ?? false).obs;
  }

  static Future<void> buyPrem() async {
    isPremiumLoading.value = true;
    final result = await Apphud.purchase(productId: 'premium_access');

    isPremiumLoading.value = false;
    if (result.error == null) {
      isPremium.value = true;
      prefs.setBool('isPremium', true);
      MySystems.showWarning('Thank you!');
    } else {
      MySystems.showWarning('Some error happens');
    }
  }

  static Future<void> restorePrem() async {
    isRestoreLoading.value = true;
    final items = await Apphud.restorePurchases();
    isRestoreLoading.value = false;
    if (items.purchases.isNotEmpty) {
      final ids = items.purchases.map((e) => e.productId).toList();
      if (ids.contains('premium_access')) {
        isPremium.value = true;
        prefs.setBool('isPremium', true);
        MySystems.showWarning('Purchase has been restored');
      } else {
        MySystems.showWarning("Didn't find purchases");
      }
    } else {
      MySystems.showWarning("Didn't find purchases");
    }
  }

  static List<PromptModel> getAllPrompts() {
    return (prefs.getStringList('prompts') ?? [])
        .map((e) => PromptModel.fromJson(json.decode(e)))
        .toList();
  }

  static List<TrackerModel> getAllTracks() {
    return (prefs.getStringList('tracks') ?? [])
        .map((e) => TrackerModel.fromJson(json.decode(e)))
        .toList();
  }

  static String getPromptsCnt() {
    return getAllPrompts().length.toString();
  }

  static Future<void> deletePrompt(PromptModel model) async {
    final prompts = getAllPrompts();
    prompts.removeWhere((e) => e.id == model.id);

    prefs.setStringList('prompts', prompts.map((e) => e.toJson()).toList());
  }

  static Future<void> deleteTrack(TrackerModel model) async {
    final prompts = getAllTracks();
    prompts.removeWhere((e) => e.id == model.id);

    prefs.setStringList('tracks', prompts.map((e) => e.toJson()).toList());
  }

  //
  static Future<void> addPrompt(PromptModel model) async {
    final prompts = getAllPrompts();
    prompts.add(model);

    prefs.setStringList('prompts', prompts.map((e) => e.toJson()).toList());
  }

  static Future<void> addTrack(TrackerModel model) async {
    final prompts = getAllTracks();
    prompts.add(model);

    prefs.setStringList('tracks', prompts.map((e) => e.toJson()).toList());
  }

  //
  static Future<void> editPrompt(PromptModel model) async {
    final prompts = getAllPrompts();
    prompts.removeWhere((e) => e.id == model.id);
    prompts.add(model);

    prefs.setStringList('prompts', prompts.map((e) => e.toJson()).toList());
  }

  static Future<void> editTrack(TrackerModel model) async {
    final prompts = getAllTracks();
    prompts.removeWhere((e) => e.id == model.id);
    prompts.add(model);

    prefs.setStringList('tracks', prompts.map((e) => e.toJson()).toList());
  }

  static String getTracksCnt() {
    return getAllTracks().length.toString();
  }

  static String getTracksSum() {
    final tracks = getAllTracks();
    if (tracks.isEmpty) {
      return '0';
    }
    int sum = 0;
    for (final track in tracks) {
      sum += track.price;
    }
    return sum.toString();
  }

  static String getPromptsAvgRate() {
    final prompts = getAllPrompts();
    if (prompts.isEmpty) {
      return '0';
    }
    int ratingSum = 0;
    for (final prompt in prompts) {
      ratingSum += prompt.rating;
    }
    return (ratingSum / (prompts.length)).toStringAsFixed(1);
  }

  static int getPromptsBusinessPerc() {
    final prompts = getAllPrompts();
    if (prompts.isEmpty) {
      return 0;
    }
    int cnt = 0;
    for (final prompt in prompts) {
      if (prompt.type == 'Business') {
        cnt++;
      }
    }
    return (cnt / (prompts.length) * 100).round();
  }

  static int getPromptsCodePerc() {
    final prompts = getAllPrompts();
    if (prompts.isEmpty) {
      return 0;
    }
    int cnt = 0;
    for (final prompt in prompts) {
      if (prompt.type == 'Code') {
        cnt++;
      }
    }
    return (cnt / (prompts.length) * 100).round();
  }

  static int getPromptsCreativePerc() {
    final prompts = getAllPrompts();
    if (prompts.isEmpty) {
      return 0;
    }
    int cnt = 0;
    for (final prompt in prompts) {
      if (prompt.type == 'Creative') {
        cnt++;
      }
    }
    return (cnt / (prompts.length) * 100).round();
  }

  static List<PromptBlockModel> getPromptBlocks() {
    final prompts = getAllPrompts();
    final Map<String, List<PromptModel>> data = {};

    for (final prompt in prompts) {
      if (!data.keys.contains(prompt.type)) {
        data.addAll({prompt.type: []});
      }
      data[prompt.type]!.add(prompt);
    }

    final List<PromptBlockModel> blocks = [];
    for (final key in data.keys) {
      blocks.add(PromptBlockModel(type: key, prompts: data[key]!));
    }

    return blocks;
  }

  static List<PromptModel> getTopRatedBlocks() {
    final prompts = getAllPrompts();
    int maxRate = 0;

    for (final prompt in prompts) {
      if (maxRate < prompt.rating) {
        maxRate = prompt.rating;
      }
    }

    final List<PromptModel> blocks = [];
    for (final prompt in prompts) {
      if (prompt.rating == maxRate) {
        blocks.add(prompt);
      }
    }

    return blocks;
  }

  static List<PromptModel> getTopViewedBlocks() {
    final prompts = getAllPrompts();
    int maxRate = 0;

    for (final prompt in prompts) {
      if (maxRate < prompt.viewedCnt) {
        maxRate = prompt.viewedCnt;
      }
    }

    final List<PromptModel> blocks = [];
    for (final prompt in prompts) {
      if (prompt.viewedCnt == maxRate) {
        blocks.add(prompt);
      }
    }

    return blocks;
  }
}
