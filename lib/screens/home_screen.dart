import 'package:flutter/material.dart';
import 'package:hire_up_poc_2/app_ctrl.dart';
import 'package:hire_up_poc_2/screens/job_book_screen.dart';
import 'package:hire_up_poc_2/screens/search_screen.dart';
import 'package:hire_up_poc_2/utils.dart';
import 'package:hire_up_poc_2/widgets/base_scaffold.dart';
import 'package:hire_up_poc_2/widgets/job_card.dart';
import 'package:hire_up_poc_2/widgets/search_field.dart';

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
                        Img.app_icon.image(size: 120),

                        IconButton(
                          style: ButtonStyle().min,
                          onPressed: () {
                            context.go(JobBookScreen());
                          },
                          icon: Icons.bookmark_outline.icon(size: 38),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      '안녕하세요, '.text(.new().b18.cg),
                      '${appCtrl.user.value?.name ?? '게스트'}님!'.text(
                        .new().b18.cb,
                      ),
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
                        context.go(SearchScreen());
                      },
                      child: SearchField(
                        enable: false,
                        h: '직무, 회사, 키워드 검색',
                        p: Icons.search.icon(color: grey),
                        padding: .zero,
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
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  Category category = .who;
  Sort sort = .latest;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          padding: .symmetric(horizontal: 18),
          scrollDirection: .horizontal,
          child: Row(
            spacing: 18,
            children: Category.values
                .map(
                  (e) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: .symmetric(vertical: 12, horizontal: 32),
                      backgroundColor: category == e ? blue : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: .circular(32),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        category = e;
                      });
                    },
                    child: e.label.text(
                      TextStyle(color: category == e ? Colors.white : grey).b14,
                    ),
                  ),
                )
                .toList(),
          ),
        ),

        18.pa(
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              '전체 공고'.text(.new().b24),
              PopupMenuButton<Sort>(
                onSelected: (value) {
                  setState(() {
                    sort = value;
                  });
                },
                itemBuilder: (context) => Sort.values
                    .map((e) => PopupMenuItem(value: e, child: e.label.text()))
                    .toList(),
                child: Row(
                  children: [
                    sort.label.text(.new().b14.cg),
                    Icons.keyboard_arrow_down.icon(color: grey),
                  ],
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: 18.pw(
            child: FutureBuilder(
              future: appCtrl.loadJobList(
                context,
                category: category,
                sort: sort,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == .waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ValueListenableBuilder(
                  valueListenable: appCtrl.bookmarkList,
                  builder: (context, value, child) => SingleChildScrollView(
                    child: Column(
                      spacing: 12,
                      children: (snapshot.data ?? [])
                          .map((e) => JobCard(model: e))
                          .toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
