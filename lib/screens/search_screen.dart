import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_up_poc_4/app_ctrl.dart';
import 'package:hire_up_poc_4/widgets/base_scaffold.dart';
import 'package:http/http.dart';

import '../utils.dart';
import '../widgets/job_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController keyword = TextEditingController();
  Timer? _timer;

  Widget? deleteIcon;

  bool showRes = false;

  @override
  void initState() {
    keyword.addListener(() {
      if (keyword.text.isNotEmpty) {
        setState(() {
          deleteIcon = IconButton(
            onPressed: () {
              setState(() {
                _timer?.cancel();
                keyword.clear();
              });
            },
            icon: Icons.close.icon(color: grey),
          );
        });
      } else {
        setState(() {
          deleteIcon = null;
          showRes = false;
        });
      }
    });

    super.initState();
  }

  void submit(String value) {
    keyword.text = value;
    appCtrl.localTags.value.add(value);
    appCtrl.saveTag();
    setState(() {
      showRes = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: .circular(12),
            border: .all(color: grey),
          ),
          margin: .all(1),
          child: TextField(
            onChanged: (value) {
              _timer?.cancel();
              _timer = Timer(Duration(seconds: 1), () => submit(value));
            },
            onSubmitted: submit,
            controller: keyword,
            decoration: InputDecoration(
              border: .none,
              prefixIcon: Icons.search.icon(color: grey),
              hintText: '직무, 회사, 키워드 검색',
              contentPadding: .symmetric(vertical: 16),
              suffixIcon: deleteIcon,
            ),
          ),
        ),
      ),
      child: 18.pw(
        child: showRes
            ? _Body(keyword: keyword.text)
            : Column(
                spacing: 18,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      '최근 검색어'.text(style: .new().b18),
                      TextButton(
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: '모든 최근 검색어를 삭제하시겠습니까?'.text(
                                style: .new().b18,
                              ),
                              actions: [
                                CupertinoButton(
                                  child: '취소'.text(),
                                  onPressed: () {
                                    context.back();
                                  },
                                ),
                                CupertinoButton(
                                  child: '삭제'.text(),
                                  onPressed: () {
                                    appCtrl.localTags.value.clear();
                                    appCtrl.saveTag();
                                    '모든 최근 검색어가 삭제되었습니다.'.snack(context);
                                    context.back();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: '전체 삭제'.text(style: .new().b14.cg),
                      ),
                    ],
                  ),

                  ValueListenableBuilder(
                    valueListenable: appCtrl.localTags,
                    builder: (context, value, child) {
                      return Row(
                        children: [
                          Expanded(
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              alignment: .start,
                              children: value
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
                                            Icons.timer_outlined.icon(),
                                            e.text(style: .new().b14.cg),
                                          ],
                                        ),
                                        onDeleted: () {
                                          appCtrl.localTags.value.remove(e);
                                          appCtrl.saveTag();
                                        },
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: ['인기 검색어'.text(style: .new().b18)],
                  ),

                  FutureBuilder(
                    future: _loadTags(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == .waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return Row(
                        children: [
                          Expanded(
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              alignment: .start,
                              children: (snapshot.data ?? [])
                                  .map(
                                    (e) => ActionChip(
                                      onPressed: () {
                                        submit(e);
                                      },
                                      color: .all(Colors.white),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: .circular(32),
                                      ),
                                      label: e.text(style: .new().b14.cg),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key, required this.keyword});

  final String keyword;

  @override
  Widget build(BuildContext context) {
    return 18.ph(
      child: FutureBuilder(
        future: appCtrl.loadJobList(context, keyword: keyword),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == .waiting)
            return Center(child: CircularProgressIndicator());

          if (asyncSnapshot.data == null || asyncSnapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: .center,
                spacing: 12,
                children: [
                  Icons.search.icon(size: 58, color: grey),
                  '검색 결과가 없습니다'.text(style: .new().b16.cg),
                  '다른 키워드로 검색해보세요'.text(style: .new().cg),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              spacing: 12,
              children: (asyncSnapshot.data ?? [])
                  .map((e) => JobCard(model: e))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}

Future<List<String>> _loadTags(BuildContext context) async {
  try {
    final res = await get(Uri.parse('$baseUrl/search/popular'));

    final body = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return (body['data']['keywords'] as List)
          .map((e) => e.toString())
          .toList();
    }
  } catch (e) {
    print(e);
  }

  return [];
}
