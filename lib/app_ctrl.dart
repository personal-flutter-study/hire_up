import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hire_up_poc_2/main.dart';
import 'package:hire_up_poc_2/models/job_model.dart';
import 'package:hire_up_poc_2/models/user_model.dart';
import 'package:hire_up_poc_2/utils.dart';
import 'package:http/http.dart';

final appCtrl = AppCtrl();

class AppCtrl {
  final ValueNotifier<UserModel?> user = ValueNotifier(null);
  final bookmarksKey = 'bookmarksKey';
  final tokenKey = 'tokenKey';

  ValueNotifier<List<int>> bookmarkList = ValueNotifier([]);

  void bookmark(int id) {
    final list = loadBookmarkList();
    if (!list.remove(id)) list.add(id);
    prefs.setStringList(bookmarksKey, list.map((e) => e.toString()).toList());
    bookmarkList.value = list;
  }

  List<int> loadBookmarkList() {
    final res = prefs.getStringList(bookmarksKey) ?? [];

    print(res);
    return res.map((e) => int.parse(e)).toList();
  }

  Future<List<JobModel>> loadJobList(
    BuildContext context, {
    Category? category,
    Sort? sort,
    String? page,
  }) async {
    try {
      final res = await get(
        Uri.parse('$baseUrl/jobs').replace(
          queryParameters: {
            'category': category?.value,
            'sort': sort?.value,
            'page': page,
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

  Future<bool> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      final res = await post(
        headers: baseHeader,
        Uri.parse('$baseUrl/auth/login'),
        body: jsonEncode({"email": email, "password": password}),
      );

      final body = jsonDecode(res.body);

      if (res.statusCode == 200) {
        final data = body['data'];
        prefs.setString(tokenKey, data['token']);
        user.value = UserModel.fromJson(data['user']);
        '로그인 성공'.snack(context);
        return true;
      } else {
        (body['errors'] as List?)?.forEach(
          (element) => (element['message'] as String?)?.snack(context),
        );
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
