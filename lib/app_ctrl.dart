import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hire_up_poc_5/main.dart';
import 'package:hire_up_poc_5/models/job_model.dart';
import 'package:hire_up_poc_5/models/user_model.dart';
import 'package:hire_up_poc_5/screens/home_screen.dart';
import 'package:hire_up_poc_5/utils.dart';
import 'package:http/http.dart';

final appCtrl = AppCtrl();

class AppCtrl {
  ValueNotifier<int> ticker = ValueNotifier(0);
  ValueNotifier<int> page = ValueNotifier(0);



  String token = '';
  UserModel? user;

  List<int> bookmarks = [];

  void bookmark(int id) {
    if (!bookmarks.remove(id)) bookmarks.add(id);
    prefs.setStringList(
      keyBookmarks,
      bookmarks.map((e) => e.toString()).toList(),
    );
    change();
  }

  change() => ticker.value++;

  Future<List<JobModel>> loadJobs(context, {ST? st, CG? cg, String? k}) async {
    try {
      final res = await get(
        Uri.parse('$baseUrl/jobs').replace(
          queryParameters: {'category': cg?.v, 'sort': st?.v, 'keyword': k}
            ..removeWhere((key, value) => value == null),
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
