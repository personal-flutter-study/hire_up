import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hire_up_poc_3/main.dart';
import 'package:hire_up_poc_3/models/job_model.dart';
import 'package:hire_up_poc_3/models/user_model.dart';
import 'package:hire_up_poc_3/screens/home_screen.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:http/http.dart';

final AppCtrl appCtrl = AppCtrl();

class AppCtrl {
  ValueNotifier<UserModel?> user = ValueNotifier(null);
  final ValueNotifier<List<int>> bookmarks = ValueNotifier([]);
  final ValueNotifier<List<String>> localTags = ValueNotifier([]);

  static const _bookmarksKey = '_bookmarksKey';
  static const _tagsKey = '_tagsKey';

  void bookmark(int id) {
    final list = loadBookmarks();
    if (!list.remove(id)) list.add(id);
    prefs.setStringList(_bookmarksKey, list.map((e) => e.toString()).toList());
    bookmarks.value = list;
  }

  List<int> loadBookmarks() {
    final list =
        prefs.getStringList(_bookmarksKey)?.map((e) => int.parse(e)).toList() ??
        [];

    bookmarks.value = list;
    return list;
  }

  void saveTag(String tag, {bool? remove, bool? removeAll}) {
    final list = loadTags();

    if (remove == true) {
      list.remove(tag);
    } else {
      list.add(tag);
    }

    if (removeAll == true) {
      list.clear();
    }

    prefs.setStringList(_tagsKey, list);
    localTags.value = list;
  }

  List<String> loadTags() {
    final list = prefs.getStringList(_tagsKey) ?? [];

    localTags.value = list;
    return list;
  }

  Future<List<JobModel>> loadJobList(
    BuildContext context, {
    Category? category,
    Sort? sort,
    String? keyword,
  }) async {
    try {
      final res = await get(
        Uri.parse('$baseUri/jobs').replace(
          queryParameters: {
            'category': category?.value,
            'sort': sort?.value,
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
      '공고 목록 조회 실패'.snack(context);
    }
    return [];
  }

  Future<List<String>> loadPopularTags(BuildContext context) async {
    try {
      final res = await get(Uri.parse('$baseUri/search/popular'));
      final body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return (body['data']['keywords'] as List)
            .map((e) => e.toString())
            .toList();
      }
    } catch (e) {
      print(e);
      '인기 검색어 조회'.snack(context);
    }
    return [];
  }

  Future<bool> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      final res = await post(
        Uri.parse('$baseUri/auth/login'),
        body: jsonEncode({"email": email, "password": password}),
        headers: baseHeader,
      );

      final body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        user.value = UserModel.fromJson(body['data']['user']);
        return true;
      } else {
        for (var e in (body['errors'] as List)) {
          (e['message'] as String).snack(context);
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
