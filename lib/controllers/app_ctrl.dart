import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hire_up_poc_1/main.dart';
import 'package:hire_up_poc_1/models/interview_model.dart';
import 'package:hire_up_poc_1/models/job_model.dart';
import 'package:hire_up_poc_1/models/rmd_job_model.dart';
import 'package:hire_up_poc_1/models/user_model.dart';
import 'package:hire_up_poc_1/widgets/utils.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appCtrl = AppCtrl();

class AppCtrl {
  late final ValueNotifier<UserModel?> user = ValueNotifier(null)
    ..addListener(() {
      if (user.value != null) {
        signIn = true;
      }
    });

  bool signIn = false;

  static const String tokenKey = '_tokenKey';
  static const String _bookmarksKey = '_bookmarksKey';
  static const String _interviewKey = '_interviewHistoryKey';

  final ValueNotifier<List<int>> bookmarkList = ValueNotifier([]);

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void bookmark(int id) {
    if (!bookmarkList.value.remove(id)) bookmarkList.value.add(id);
    prefs.setString(_bookmarksKey, jsonEncode(bookmarkList.value));
    bookmarkList.value = List.of(bookmarkList.value);
  }

  Future<List<JobModel>> loadJobList(
    BuildContext context, {
    Sort? sort,
    CateGory? cate,
    String? keyword,
  }) async {
    final res = await get(
      Uri.parse('$baseUrl/jobs').replace(
        queryParameters: {
          'sort': sort?.value,
          'category': cate?.value,
          'keyword': keyword,
        }..removeWhere((key, value) => value == null),
      ),
    );

    if (res.statusCode == 200) {
      print('조회 성공');
      return (jsonDecode(res.body)['data']['items'] as List)
          .map((e) => JobModel.fromJson(e))
          .toList();
    }

    '조회 서버 통신 오류'.snack(context);

    return [];
  }

  Future<List<RmdJobModel>> loadRmdJobList(
    BuildContext context, {
    Sort? sort,
    CateGory? cate,
    String? keyword,
  }) async {
    final res = await get(Uri.parse('$baseUrl/jobs/recommended'));

    if (res.statusCode == 200) {
      print('오늘의 추천 공고 조회 성공');
      return (jsonDecode(res.body)['data']['items'] as List)
          .map((e) => RmdJobModel.fromJson(e))
          .toList();
    }

    '오늘의 추천 공고 조회 서버 통신 오류'.snack(context);

    return [];
  }

  void saveInterview(InterviewModel model) {
    final list = loadInterview();

    list.add(model);

    prefs.setStringList(
      _interviewKey,
      list.map((e) => jsonEncode(e.toJson())).toList(),
    );

    print('저장 성공');
  }

  List<InterviewModel> loadInterview() {
    return prefs
            .getStringList(_interviewKey)
            ?.map((e) => InterviewModel.fromJson(jsonDecode(e)))
            .toList() ??
        [];
  }
}
