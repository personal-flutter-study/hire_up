import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hire_up_poc_3/main.dart';
import 'package:hire_up_poc_3/models/job_model.dart';
import 'package:hire_up_poc_3/models/recommend_job_model.dart';
import 'package:hire_up_poc_3/models/user_model.dart';
import 'package:hire_up_poc_3/screens/home_screen.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:http/http.dart';

final AppCtrl appCtrl = AppCtrl();

class AppCtrl {
  ValueNotifier<int> page = ValueNotifier(0);

  ValueNotifier<String?> token = ValueNotifier(null);

  UserModel? user;

  final ValueNotifier<List<int>> bookmarks = ValueNotifier([]);
  final ValueNotifier<List<String>> localTags = ValueNotifier([]);

  static const bookmarksKey = '_bookmarksKey';
  static const tagsKey = '_tagsKey';
  static const profileKey = '_profileKey';

  void bookmark(int id) {
    final list = loadBookmarks();
    if (!list.remove(id)) list.add(id);
    prefs.setStringList(bookmarksKey, list.map((e) => e.toString()).toList());
    bookmarks.value = list;
  }

  List<int> loadBookmarks() {
    final list =
        prefs.getStringList(bookmarksKey)?.map((e) => int.parse(e)).toList() ??
        [];

    bookmarks.value = list;
    return list;
  }

  void saveProfile(String path) {
    prefs.setString(profileKey, path);
  }

  String? get profilePath => prefs.getString(profileKey);

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

    prefs.setStringList(tagsKey, list);
    localTags.value = list;
  }

  List<String> loadTags() {
    final list = prefs.getStringList(tagsKey) ?? [];

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

  Future<List<RecommendJobModel>> loadRecommendJobList(
    BuildContext context, {
    Category? category,
    Sort? sort,
    String? keyword,
  }) async {
    try {
      final res = await get(Uri.parse('$baseUri/jobs/recommended'));
      final body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return (body['data']['items'] as List)
            .map((e) => RecommendJobModel.fromJson(e))
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
        user = UserModel.fromJson(body['data']['user']);

        token.value = body['data']['token'];
        print(token.value);

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
