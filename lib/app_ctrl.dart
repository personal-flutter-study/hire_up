import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hire_up_poc_4/main.dart';
import 'package:hire_up_poc_4/models/job_model.dart';
import 'package:hire_up_poc_4/models/user_model.dart';
import 'package:hire_up_poc_4/screens/home_screen.dart';
import 'package:hire_up_poc_4/utils.dart';
import 'package:http/http.dart';

final appCtrl = AppCtrl();

class AppCtrl {
  Future init() async {
    bookmarks.value =
        prefs.getStringList(_keyBookmarks)?.map((e) => int.parse(e)).toList() ??
        [];
  }

  final ValueNotifier<UserModel?> user = ValueNotifier(null);

  final ValueNotifier<List<int>> bookmarks = ValueNotifier([]);
  final ValueNotifier<List<String>> localTags = ValueNotifier([]);

  static const _keyBookmarks = '_keyBookmarks';
  static const _keyLocalTags = '_keyLocalTags';

  void bookmark(int id) {
    final list = List.of(bookmarks.value);
    if (!list.remove(id)) list.add(id);
    prefs.setStringList(_keyBookmarks, list.map((e) => e.toString()).toList());
    bookmarks.value = list;
  }

  void saveTag() {
    final list = List.of(localTags.value);
    prefs.setStringList(_keyLocalTags, list.map((e) => e.toString()).toList());
    localTags.value = list;
  }

  Future<List<JobModel>> loadJobList(
    BuildContext context, {
    Category? category,
    Sort? sort,
    String? keyword,
  }) async {
    try {
      final res = await get(
        Uri.parse('$baseUrl/jobs').replace(
          queryParameters: {
            'category': category?.v,
            'sort': sort?.v,
            'keyword': keyword,
          }..removeWhere((key, value) => value == null),
        ),
      );

      final body = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return (body['data']['items'] as List)
            .map((e) => JobModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      print(e);
    }

    return [];
  }
}
