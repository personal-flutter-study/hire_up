import 'package:flutter/material.dart';
import 'package:hire_up_poc_4/app_ctrl.dart';
import 'package:hire_up_poc_4/screens/job_book_screen.dart';
import 'package:hire_up_poc_4/screens/search_screen.dart';
import 'package:hire_up_poc_4/utils.dart';
import 'package:hire_up_poc_4/widgets/base_scaffold.dart';
import 'package:hire_up_poc_4/widgets/job_card.dart';

enum Category {
  HR('HR', '전체'),
  DEV('DEV', '개발'),
  DESIGN('DESIGN', '디자인'),
  MARKETING('MARKETING', '마케팅');

  final String v;
  final String l;

  const Category(this.v, this.l);
}

enum Sort {
  latest('latest', '최신순'),
  popular('popular', '인기순'),
  salary('salary', '급여순');

  final String v;
  final String l;

  const Sort(this.v, this.l);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appCtrl.user,
      builder: (context, value, child) => BaseScaffold(
        appBar: AppBar(
          leading: 18.pw(child: "assets/images/app_icon.png".image()),
          leadingWidth: 140,
          toolbarHeight: 80,
          actions: [
            IconButton(
              onPressed: () {
                context.go(JobBookScreen());
              },
              icon: Icons.bookmark_outline.icon(size: 38),
            ),
          ],
        ),
        child: 18.pw(
          child: SingleChildScrollView(
            child: Column(
              spacing: 18,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        '안녕하세요, '.text(style: TextStyle(fontSize: 16)),
                        '${appCtrl.user.value?.name ?? '게스트'}님!'.text(
                          style: .new().b16.cb,
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        '새로운 기회'.text(style: .new().b18.cb),
                        '를 찾아보세요.'.text(style: .new().b18),
                      ],
                    ),
                  ],
                ),

                GestureDetector(
                  onTap: () {
                    context.go(SearchScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: .circular(12),
                      border: .all(color: grey),
                    ),
                    margin: .all(1),
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        border: .none,
                        prefixIcon: Icons.search.icon(color: grey),
                        hintText: '직무, 회사, 키워드 검색',
                        contentPadding: .symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ),

                _Body(),
              ],
            ),
          ),
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
      spacing: 18,
      children: [
        SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            spacing: 12,
            children: Category.values.map((e) {
              final active = category == e;

              return ActionChip(
                onPressed: () {
                  setState(() {
                    category = e;
                  });
                },
                color: .all(active ? blue : Colors.white),
                shape: RoundedRectangleBorder(borderRadius: .circular(32)),
                label: 18.pw(
                  child: 4.ph(
                    child: e.l.text(
                      style: TextStyle(color: active ? Colors.white : grey).b14,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            '전체 공고'.text(style: TextStyle().b20),
            PopupMenuButton(
              color: Colors.white,
              onSelected: (value) {
                setState(() {
                  sort = value;
                });
              },
              itemBuilder: (context) => Sort.values
                  .map((e) => PopupMenuItem(child: e.l.text(), value: e))
                  .toList(),
              child: Row(
                mainAxisSize: .min,
                children: [
                  sort.l.text(style: .new().b14.cg),
                  Icons.keyboard_arrow_down.icon(color: grey),
                ],
              ),
            ),
          ],
        ),

        FutureBuilder(
          future: appCtrl.loadJobList(context, sort: sort, category: category),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == .waiting)
              return Center(child: CircularProgressIndicator());
            return Column(
              spacing: 12,
              children: (asyncSnapshot.data ?? [])
                  .map((e) => JobCard(model: e))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
