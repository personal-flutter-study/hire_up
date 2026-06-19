import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/controllers/app_ctrl.dart';
import 'package:hire_up_poc_1/main.dart';
import 'package:hire_up_poc_1/widgets/base_scaffold.dart';
import 'package:hire_up_poc_1/widgets/job_card.dart';
import 'package:hire_up_poc_1/widgets/search_field.dart';
import 'package:hire_up_poc_1/widgets/utils.dart';
import 'package:http/http.dart';

final _controller = _SearchController();

class _SearchController {
  final TextEditingController keyword = TextEditingController();
  final ValueNotifier<bool> submit = ValueNotifier(false);

  Timer? timer;
  static const String _keywordsKey = '_keywordsKey';

  void onSubmit() {
    if (keyword.text.isNotEmpty) {
      saveKeyword(k: keyword.text);
      submit.value = true;
    }
  }

  Future<List<String>> loadRemoteTagList(BuildContext context) async {
    final res = await get(Uri.parse('$baseUrl/search/popular'));
    if (res.statusCode == 200) {
      print('인기 검색어 조회 성공');
      return (jsonDecode(res.body)['data']['keywords'] as List)
          .map((e) => e.toString())
          .toList();
    }
    '인기 검색어 조회 서버 오류'.snack(context);
    return [];
  }

  void saveKeyword({String? k, bool remove = false}) {
    final list = loadLocalKeywords().toSet();

    if (k != null) {
      if (remove) {
        list.remove(k);
      } else {
        list.add(k);
      }
    } else {
      if (remove) {
        list.clear();
      }
    }

    prefs.setStringList(_keywordsKey, list.toList());
  }

  List<String> loadLocalKeywords() {
    return prefs.getStringList(_keywordsKey) ?? [];
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: ValueListenableBuilder(
        valueListenable: _controller.submit,
        builder: (context, value, child) => Column(
          children: [
            _SearchBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: value
                    ? _ResultBody(keyword: _controller.keyword.text)
                    : _SearchBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  Timer get timer => Timer(Duration(seconds: 1), _controller.onSubmit);

  @override
  Widget build(BuildContext context) {
    return 18.pa(
      Row(
        children: [
          IconButton(
            onPressed: () {
              if (_controller.submit.value) {
                _controller.submit.value = false;
                _controller.keyword.clear();
              } else {
                context.back();
              }
            },
            icon: Icon(Icons.arrow_back_ios),
          ),

          Expanded(
            child: SearchField(
              onChange: (m) {
                _controller.timer?.cancel();
                _controller.timer = timer;
              },
              onSubmit: (m) {
                _controller.onSubmit();
              },
              controller: _controller.keyword,
              p: Icons.search.icon(color: grey),
              h: '직무, 회사, 키워드 검색',
              s: _controller.keyword.text.isNotEmpty
                  ? IconButton(
                      style: IconButton.styleFrom().min,
                      onPressed: () {
                        _controller.keyword.clear();
                        setState(() {});
                      },
                      icon: Icon(Icons.close, color: grey),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultBody extends StatelessWidget {
  const _ResultBody({required this.keyword});

  final String keyword;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: appCtrl.loadJobList(context, keyword: keyword),
      builder: (context, snapshot) {
        if (snapshot.connectionState == .waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Column(
            mainAxisAlignment: .center,
            children: [
              Icons.search.icon(size: 58, color: grey),
              18.ph(Text('검색 결과가 없습니다', style: TextStyle().b16.cg)),
              Text('다른 키워드로 검색해보세요', style: TextStyle().b14.cg),
            ],
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              spacing: 12,
              children: snapshot.data!
                  .map((e) => JobCard(model: e, ver2: true))
                  .toList(),
            ),
          );
        }
      },
    );
  }
}

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        18.sh,

        StatefulBuilder(
          builder: (context, setState) => Column(
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text('최근 검색어', style: TextStyle().b16),
                  TextButton(
                    style: .new().min,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: Text('모든 최근 검색어를 삭제하시겠습니까?'),
                          actions: [
                            CupertinoButton(
                              child: Text('삭제'),
                              onPressed: () {
                                setState(() {
                                  _controller.saveKeyword(remove: true);
                                });
                                context.back();
                              },
                            ),
                            CupertinoButton(
                              child: Text('취소'),
                              onPressed: () {
                                context.back();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text('전체 삭제', style: TextStyle().b14.cg),
                  ),
                ],
              ),

              18.ph(
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 50),
                  child: Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _controller
                              .loadLocalKeywords()
                              .map(
                                (e) => ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    _controller.keyword.text = e;
                                    _controller.onSubmit();
                                  },
                                  child: Row(
                                    mainAxisSize: .min,
                                    spacing: 8,
                                    children: [
                                      Text(e, style: TextStyle().b14.cg),
                                      IconButton(
                                        style: IconButton.styleFrom().min,
                                        onPressed: () {
                                          setState(() {
                                            _controller.saveKeyword(
                                              k: e,
                                              remove: true,
                                            );
                                          });
                                        },
                                        icon: Icon(Icons.close, color: grey),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        Column(
          children: [
            Row(children: [Text('인기 검색어', style: TextStyle().b16)]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: FutureBuilder(
                future: _controller.loadRemoteTagList(context),
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
                          children: (snapshot.data ?? [])
                              .map(
                                (e) => ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    _controller.keyword.text = e;
                                    _controller.onSubmit();
                                  },
                                  child: Text(e, style: TextStyle().b14.cg),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
