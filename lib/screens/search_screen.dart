import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/app_ctrl.dart';
import 'package:hire_up_poc_3/screens/job_detail_screen.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';
import 'package:hire_up_poc_3/widgets/job_card.dart';
import 'package:hire_up_poc_3/widgets/search_field.dart';

import '../widgets/bookmark_button.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController keyword = TextEditingController();

  Timer? _timer;

  bool showRes = false;

  void submit(String value) {
    appCtrl.saveTag(value);
    setState(() {
      showRes = true;
    });
    keyword.text = value;
    print('submit');
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: SearchField(
          change: (value) {
            _timer?.cancel();
            _timer = Timer(Duration(seconds: 1), () {
              submit(value);
            });
          },
          submit: submit,
          controller: keyword,
          p: Icons.search.icon(color: grey),
          h: '직무, 회사, 키워드 검색',
        ),
      ),
      child: 12.pa(
        child: showRes
            ? _ResultPage(keyword: keyword.text)
            : Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      '최근 검색어'.text(.new().b18),
                      TextButton(
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: '모든 최근 검색어를 삭제하시겠습니까?'.text(.new().b18),
                              actions: [
                                CupertinoButton(
                                  child: '취소'.text(),
                                  onPressed: () {
                                    context.pop();
                                  },
                                ),
                                CupertinoButton(
                                  child: '삭제'.text(),
                                  onPressed: () {
                                    context.pop();
                                    appCtrl.saveTag('', removeAll: true);
                                    '모든 최근 검색어가 삭제되었습니다.'.snack(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: '전체 삭제'.text(.new().b16.cg),
                      ),
                    ],
                  ),

                  ValueListenableBuilder(
                    valueListenable: appCtrl.localTags,
                    builder: (context, value, child) {
                      return Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: appCtrl.localTags.value
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  submit(e);
                                },
                                child: Chip(
                                  color: .all(Colors.white),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: .circular(32),
                                  ),
                                  label: Row(
                                    mainAxisSize: .min,
                                    children: [
                                      Icons.timer.icon(color: grey),
                                      e.text(.new().b16.cg),
                                    ],
                                  ),
                                  onDeleted: () {
                                    appCtrl.saveTag(e, remove: true);
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),

                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: ['인기 검색어'.text(.new().b18)],
                  ),

                  FutureBuilder(
                    future: appCtrl.loadPopularTags(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == .waiting)
                        return Center(child: CircularProgressIndicator());

                      return Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: (snapshot.data ?? [])
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  submit(e);
                                },
                                child: Chip(
                                  color: .all(Colors.white),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: .circular(32),
                                  ),
                                  label: e.text(.new().b16.cg),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

class _ResultPage extends StatelessWidget {
  const _ResultPage({super.key, required this.keyword});

  final String keyword;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: appCtrl.loadJobList(context, keyword: keyword),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == .waiting)
          return Center(child: CircularProgressIndicator());

        if (asyncSnapshot.data == null || asyncSnapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Icons.search.icon(size: 88, color: grey),
                '검색 결과가 없습니다'.text(.new().b18.cg),
                '다른 키워드로 검색해보세요'.text(.new().b16.cg),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: asyncSnapshot.data!
                .map(
                  (model) => GestureDetector(
                    onTap: () {
                      context.push(JobDetailScreen());
                    },
                    child: Card(
                      color: Colors.white,
                      child: 18.pa(
                        child: Row(
                          spacing: 18,
                          crossAxisAlignment: .start,
                          children: [
                            Image.network(
                              model.companyLogo,
                              fit: .fitWidth,
                              width: 60,
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: .start,
                                spacing: 8,
                                children: [
                                  Row(
                                    mainAxisAlignment: .spaceBetween,
                                    children: [
                                      model.companyName.text(.new().b14.cg),
                                      model.deadlineLabel.text(.new().b14.cg),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: .spaceBetween,
                                    children: [
                                      model.jobTitle.text(.new().b16),
                                      Icons.arrow_forward_ios.icon(color: grey),
                                    ],
                                  ),

                                  '${model.location} · ${model.employmentType}'
                                      .text(.new().b14.cg),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
