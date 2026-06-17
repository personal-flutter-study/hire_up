import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hire_up_poc_1/main.dart';
import 'package:hire_up_poc_1/models/job_model.dart';
import 'package:hire_up_poc_1/models/user_model.dart';
import 'package:hire_up_poc_1/screeens/home_screen.dart';
import 'package:hire_up_poc_1/widgets/utils.dart';
import 'package:http/http.dart';

final appCtrl = AppCtrl();

class AppCtrl {
  UserModel? user;

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

    final body = jsonDecode(res.body);

    if (res.statusCode == 200) {
      print('조회 성공');
      return (body['data']['items'] as List)
          .map((e) => JobModel.fromJson(e))
          .toList();
    }

    '조회 서버 통신 오류'.snack(context);

    return [];
  }
}
