import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_up_poc_5/app_ctrl.dart';
import 'package:hire_up_poc_5/main.dart';
import 'package:hire_up_poc_5/utils.dart';
import 'package:hire_up_poc_5/widgets/base_scaffold.dart';
import 'package:hire_up_poc_5/widgets/job_card.dart';
import 'package:http/http.dart';

import 'job_detail_screen.dart';

List<String> localTags = [];

const String keyLocalTags = 'keyLocalTags';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController keyword = TextEditingController();

  Timer? _timer;

  bool showRes = false;

  void submit(String v) {
    setState(() {
      localTags = (localTags.toSet()..add(v)).toList();
      keyword.text = v;
      showRes = true;
      print(localTags);
    });
    prefs.setString(keyLocalTags, jsonEncode(localTags));
  }

  @override
  void initState() {
    super.initState();

    localTags = (jsonDecode(prefs.getString(keyLocalTags) ?? '[]') as List)
        .map((e) => e.toString())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        leading: Icons.arrow_back_ios.iButton(() {
          context.back();
        }),
        title: 1.pa(
          child: TextField(
            controller: keyword,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  showRes = false;
                });
              }
              _timer?.cancel();
              _timer = Timer(Duration(seconds: 1), () {
                submit(value);
              });
            },
            onSubmitted: submit,
            decoration: InputDecoration(
              suffixIcon: keyword.text.isNotEmpty
                  ? Icons.close.iButton(() {
                      setState(() {
                        showRes = false;
                        keyword.clear();
                      });
                    })
                  : null,
              hintText: '직무, 회사, 키워드 검색',
              prefixIcon: Icons.search.icon(),
              contentPadding: .symmetric(horizontal: 24, vertical: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: .circular(12),
                borderSide: BorderSide(color: grey, width: 1.5),
              ),
              border: OutlineInputBorder(
                borderRadius: .circular(12),
                borderSide: BorderSide(color: grey, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: .circular(12),
                borderSide: BorderSide(color: grey, width: 1.5),
              ),
            ),
          ),
        ),
      ),
      child: 18.pa(
        child: showRes
            ? _Body(k: keyword.text)
            : Column(
                spacing: 18,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      '최근 검색어'.text(TextStyle().b20),
                      '전체 삭제'.tButton(() {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: '모든 최근 검색어를 삭제하시겠습니까?'.text(),
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
                                  setState(() {
                                    localTags.clear();
                                    prefs.setString(
                                      keyLocalTags,
                                      jsonEncode(localTags),
                                    );
                                  });

                                  '삭제 완료'.toast();
                                  context.back();
                                },
                              ),
                            ],
                          ),
                        );
                      }, tStyle: TextStyle().b16.cg),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: localTags
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
                                      spacing: 8,
                                      mainAxisSize: .min,
                                      children: [
                                        Icons.watch_later_outlined.icon(),
                                        e.text(TextStyle().cg),
                                      ],
                                    ),
                                    deleteIcon: Icons.close.icon(),
                                    onDeleted: () {
                                      localTags.remove(e);
                                      prefs.setString(
                                        keyLocalTags,
                                        jsonEncode(localTags),
                                      );
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: ['인기 검색어'.text(TextStyle().b20)],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: FutureBuilder(
                          future: _load(context),
                          builder: (context, asyncSnapshot) {
                            if (asyncSnapshot.connectionState == .waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            final data = asyncSnapshot.data;

                            if (data == null) {
                              return Center(
                                child: '조회할 수 없습니다.'.text(TextStyle().b24),
                              );
                            }

                            return Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: data
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
                                          spacing: 8,
                                          mainAxisSize: .min,
                                          children: [e.text(TextStyle().cg)],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key, required this.k});

  final String k;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: appCtrl.loadJobs(context, k: k),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == .waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final data = asyncSnapshot.data;

        if (data == null || data.isEmpty || k.isEmpty) {
          return Center(
            child: Column(
              spacing: 8,
              mainAxisAlignment: .center,
              children: [
                Icons.search.icon(color: grey, size: 78),
                '검색 결과가 없습니다'.text(TextStyle().b20.cg),
                '다른 키워드로 검색해보세요'.text(TextStyle().b16.cg),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: data
                .map(
                  (model) => GestureDetector(
                    onTap: () {
                      context.go(JobDetailScreen());
                    },
                    child: Card(
                      color: Colors.white,
                      child: 12.pa(
                        child: Row(
                          spacing: 12,
                          crossAxisAlignment: .start,
                          children: [
                            Image.network(
                              model.companyLogo,
                              fit: .fitWidth,
                              width: 60,
                            ),

                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      spacing: 8,
                                      crossAxisAlignment: .start,
                                      children: [
                                        model.companyName.text(
                                          TextStyle(fontSize: 16),
                                        ),
                                        model.jobTitle.text(TextStyle().b18),
                                        Row(
                                          mainAxisAlignment: .spaceBetween,
                                          children: [
                                            "${model.location} · ${model.employmentType}"
                                                .text(TextStyle().cg.b14),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  Icons.arrow_forward_ios.icon(color: grey),
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

Future<List<String>> _load(context) async {
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
