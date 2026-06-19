import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hire_up_poc_1/controllers/app_ctrl.dart';
import 'package:hire_up_poc_1/main.dart';
import 'package:hire_up_poc_1/screeens/job_book_screen.dart';
import 'package:hire_up_poc_1/screeens/job_detail_screen.dart';
import 'package:hire_up_poc_1/screeens/job_rmd_screen.dart';
import 'package:hire_up_poc_1/screeens/search_screen.dart';
import 'package:hire_up_poc_1/widgets/base_scaffold.dart';
import 'package:hire_up_poc_1/widgets/job_card.dart';
import 'package:hire_up_poc_1/widgets/search_field.dart';

import '../widgets/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ValueListenableBuilder(
          valueListenable: appCtrl.user,
          builder: (context, value, child) => SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      AppImg.app_icon.image(size: 100),
                      GestureDetector(
                        onTap: () {
                          context.go(JobBookScreen());
                        },
                        child: Icons.bookmark_border_outlined.icon(size: 30),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: .symmetric(vertical: 18),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('안녕하세요, ', style: TextStyle().b14),
                          Text(
                            '${value?.name ?? '게스트'}님!',
                            style: TextStyle().b14.cb,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('새로운 기회', style: TextStyle().b18.cb),
                          Text('를 찾아보세요.', style: TextStyle().b18),
                        ],
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    context.go(SearchScreen());
                  },
                  child: SearchField(
                    enable: false,
                    h: '직무, 회사, 키워드 검색',
                    p: Icons.search.icon(color: Colors.grey),
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

class _RecommendJobList extends StatefulWidget {
  const _RecommendJobList({super.key});

  @override
  State<_RecommendJobList> createState() => _RecommendJobListState();
}

class _RecommendJobListState extends State<_RecommendJobList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        line(),
        24.sh,

        FutureBuilder(
          future: appCtrl.loadRmdJobList(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == .waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ValueListenableBuilder(
              valueListenable: appCtrl.bookmarkList,
              builder: (context, value, child) => SingleChildScrollView(
                scrollDirection: .horizontal,
                child: Row(
                  spacing: 12,
                  children: (snapshot.data ?? [])
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            context.go(JobDetailScreen(id: e.id));
                          },
                          child: Container(
                            width: 190,
                            height: 250,
                            margin: .all(1),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: .circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(100),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            padding: .all(12),
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Row(
                                  mainAxisAlignment: .spaceBetween,
                                  crossAxisAlignment: .center,
                                  children: [
                                    Card(
                                      surfaceTintColor: e.recruitStatus.color,
                                      child: 8.pa(
                                        e.recruitStatus.label.text(
                                          TextStyle(
                                            color: e.recruitStatus.color,
                                          ).b14,
                                        ),
                                      ),
                                    ),

                                    AppButton.bookmark(context, e.id),
                                  ],
                                ),

                                12.ph(
                                  SizedBox(
                                    width: .infinity,
                                    child: Image.network(
                                      e.companyLogo,
                                      fit: .fitHeight,
                                      height: 60,
                                    ),
                                  ),
                                ),

                                e.jobTitle.text(TextStyle().b16),
                                '${e.location} · ${e.employmentType}'.text(
                                  .new().b14.cg,
                                ),

                                Spacer(),

                                e.salary.text(.new().b14.cb),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget line() => Row(
    children: [
      '오늘의 추천 공고 ✨'.text(TextStyle().b18),
      Spacer(),
      TextButton(
        style: ButtonStyle().min,
        onPressed: () {
          context.go(JobRmdScreen());
        },
        child: Row(
          children: [
            '더보기'.text(TextStyle().cg),
            Icons.arrow_forward_ios.icon(color: grey),
          ],
        ),
      ),
    ],
  );
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  Sort sort = .latest;
  CateGory category = .who;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: .symmetric(vertical: 18), child: tags()),
        _RecommendJobList(),

        24.sh,

        line(),

        24.sh,

        ConstrainedBox(
          constraints: .new(maxHeight: 400),
          child: FutureBuilder(
            future: appCtrl.loadJobList(context, sort: sort, cate: category),
            builder: (context, snapshot) {
              if (snapshot.connectionState == .waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Column(
                  spacing: 18,
                  children: (snapshot.data ?? [])
                      .map((e) => JobCard(model: e))
                      .toList(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget tags() => SingleChildScrollView(
    scrollDirection: .horizontal,
    child: Row(
      children: CateGory.values
          .map(
            (e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: e == category ? Colors.white : grey,
                  backgroundColor: e == category ? blue : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    category = e;
                  });
                },
                child: Text(e.label, style: TextStyle().b14),
              ),
            ),
          )
          .toList(),
    ),
  );

  Widget line() => Row(
    mainAxisAlignment: .spaceBetween,
    children: [
      Text('전체 공고', style: TextStyle().b18),
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
                child: Text(e.label, style: TextStyle().b16),
              ),
            )
            .toList(),
        child: Row(
          children: [
            Text(sort.label, style: TextStyle().b14.cg),
            Icon(Icons.keyboard_arrow_down_outlined, color: grey),
          ],
        ),
      ),
    ],
  );
}
