import 'package:flutter/material.dart';
import 'package:hire_up_poc_5/app_ctrl.dart';
import 'package:hire_up_poc_5/screens/job_book_screen.dart';
import 'package:hire_up_poc_5/screens/search_screen.dart';
import 'package:hire_up_poc_5/utils.dart';
import 'package:hire_up_poc_5/widgets/base_scaffold.dart';
import 'package:hire_up_poc_5/widgets/job_card.dart';

enum CG {
  WH('', '전체'),
  DEV('DEV', '개발'),
  DESIGN('DESIGN', '디자인'),
  MARKETING('MARKETING', '마케팅'),
  HR('HR', '인사'),
  PM('PM', '기획');

  final String v;
  final String l;

  const CG(this.v, this.l);
}

enum ST {
  latest('latest', '최신순'),
  popular('popular', '인기순'),
  salary('salary', '급여순');

  final String v;
  final String l;

  const ST(this.v, this.l);
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
      appBar: AppBar(
        actionsPadding: .symmetric(horizontal: 18),
        leading: 18.pw(child: 'assets/images/app_icon.png'.image(120)),
        leadingWidth: 160,
        actions: [
          Icons.bookmark_outline.iButton(() {
            context.go(JobBookScreen());
          }, size: 38),
        ],
      ),
      child: 18.pw(
        child: SingleChildScrollView(
          child: Column(
            spacing: 12,
            children: [
              SizedBox(height: 12),

              Column(
                children: [
                  Row(
                    children: [
                      '안녕하세요, '.text(TextStyle().b20.cg),
                      '${appCtrl.user?.name ?? "케스트"}님!'.text(
                        TextStyle().b20.cb,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      '새로운 기회'.text(TextStyle().b20.cb),
                      '를 찾아보세요.'.text(TextStyle().b20),
                    ],
                  ),
                ],
              ),

              1.pa(
                child: GestureDetector(
                  onTap: () {
                    context.go(SearchScreen());
                  },
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
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

              _Body(),
            ],
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
  CG cg = .WH;
  ST st = .latest;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            spacing: 12,
            children: CG.values.map((e) {
              final ac = cg == e;
              return ActionChip(
                onPressed: () {
                  setState(() {
                    cg = e;
                  });
                },
                shape: RoundedRectangleBorder(borderRadius: .circular(32)),
                padding: .symmetric(horizontal: 18, vertical: 10),
                label: e.l.text(TextStyle(color: ac ? Colors.white : grey)),
                color: .all(ac ? blue : Colors.white),
              );
            }).toList(),
          ),
        ),

        SizedBox(height: 12),

        18.ph(
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              '전체 공고'.text(TextStyle().b24),
              PopupMenuButton(
                onSelected: (value) {
                  setState(() {
                    st = value;
                  });
                },
                color: Colors.white,
                child: Row(
                  children: [
                    st.l.text(.new()),
                    Icons.keyboard_arrow_down.icon(),
                  ],
                ),
                itemBuilder: (context) => ST.values
                    .map((e) => PopupMenuItem(value: e, child: e.l.text()))
                    .toList(),
              ),
            ],
          ),
        ),

        FutureBuilder(
          future: appCtrl.loadJobs(context, cg: cg, st: st),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == .waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final data = asyncSnapshot.data;

            if (data == null) {
              return Center(child: '조회할 수 없습니다.'.text(TextStyle().b24));
            }

            return Column(
              spacing: 12,
              children: data.map((e) => JobCard(model: e)).toList(),
            );
          },
        ),
      ],
    );
  }
}
