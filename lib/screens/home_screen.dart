import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/app_ctrl.dart';
import 'package:hire_up_poc_3/screens/job_book_screen.dart';
import 'package:hire_up_poc_3/screens/search_screen.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';
import 'package:hire_up_poc_3/widgets/bookmark_button.dart';
import 'package:hire_up_poc_3/widgets/job_card.dart';
import 'package:hire_up_poc_3/widgets/search_field.dart';

enum Category {
  HR('HR', '전체'),
  DEV('DEV', '개발'),
  DESIGN('DESIGN', '디자인'),
  MARKETING('MARKETING', '마케팅');

  final String value;
  final String label;

  const Category(this.value, this.label);
}

enum Sort {
  latest('latest', '최신순'),
  popular('popular', '인기순'),
  salary('salary', '급여순');

  final String value;
  final String label;

  const Sort(this.value, this.label);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: ValueListenableBuilder(
        valueListenable: appCtrl.user,
        builder: (context, value, child) => Column(
          children: [
            18.pw(
              child: Column(
                children: [
                  18.ph(
                    child: Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        'assets/images/app_icon.png'.image(120),
                        IconButton(
                          onPressed: () {
                            context.push(JobBookScreen());
                          },
                          icon: Icons.bookmark_border_outlined.icon(
                            size: 38,
                            color: grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      '안녕하세요, '.text(.new().b16.cg),
                      '${value?.name ?? '게스트'}님!'.text(.new().b16.cb),
                    ],
                  ),

                  Row(
                    children: [
                      '새로운 기회'.text(.new().b18.cb),
                      '를 찾아보세요.'.text(.new().b18),
                    ],
                  ),

                  18.ph(
                    child: GestureDetector(
                      onTap: () {
                        context.push(SearchScreen());
                      },
                      child: SearchField(
                        p: Icons.search.icon(color: grey),
                        h: '직무, 회사, 키워드 검색',
                        enable: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(child: _Body()),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({super.key});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  Category category = .HR;
  Sort sort = .latest;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          padding: .symmetric(horizontal: 18),
          scrollDirection: .horizontal,
          child: Row(
            children: Category.values.map((e) {
              final active = category == e;

              return 12.pw(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: active ? blue : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      category = e;
                    });
                  },
                  child: e.label.text(
                    TextStyle(color: active ? Colors.white : grey).b14,
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        24.sh,

        Expanded(
          child: 18.pw(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    '전체 공고'.text(.new().b24),

                    PopupMenuButton(
                      onSelected: (value) {
                        setState(() {
                          sort = value;
                        });
                      },
                      itemBuilder: (context) => Sort.values
                          .map(
                            (e) => PopupMenuItem(
                              value: e,
                              child: e.label.text(.new().b16),
                            ),
                          )
                          .toList(),
                      child: Row(
                        children: [
                          sort.label.text(.new().b16.cg),
                          Icons.keyboard_arrow_down.icon(color: grey, size: 24),
                        ],
                      ),
                    ),
                  ],
                ),

                18.sh,

                Expanded(
                  child: SingleChildScrollView(
                    child: FutureBuilder(
                      future: appCtrl.loadJobList(
                        context,
                        sort: sort,
                        category: category,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == .waiting)
                          return Center(child: CircularProgressIndicator());

                        return Column(
                          children: (snapshot.data ?? [])
                              .map((e) => JobCard(model: e))
                              .toList(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
