import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/app_ctrl.dart';
import 'package:hire_up_poc_3/main.dart';
import 'package:hire_up_poc_3/models/job_detail_model.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';
import 'package:hire_up_poc_3/widgets/bookmark_button.dart';
import 'package:hire_up_poc_3/widgets/login_bottom_sheet.dart';
import 'package:hire_up_poc_3/widgets/p_button.dart';
import 'package:http/http.dart';

Future<JobDetailModel?> _loadDetail(BuildContext context, int id) async {
  try {
    final res = await get(Uri.parse('$baseUri/jobs/$id'));
    final body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return JobDetailModel.fromJson(body['data']);
    }
  } catch (e) {
    print(e);
    '공고 상세 조회 실패'.snack(context);
  }
  return null;
}

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({super.key, required this.id});

  final int id;

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen>
    with TickerProviderStateMixin {
  late final TabController controller;

  int page = 0;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadDetail(context, widget.id),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == .waiting)
          return Center(child: CircularProgressIndicator());

        if (asyncSnapshot.data == null) {
          Center(child: '해당 공고는 찾을 수 없습니다.'.text());
        }

        final data = asyncSnapshot.data!;

        final status = data.recruitStatus;

        return BaseScaffold(
          appBar: AppBar(
            leading: _iconButtonG(Icons.arrow_back_ios, () {}),
            actions: [
              _iconButtonG(Icons.ios_share, () async {
                platformM.invokeMethod('share', {
                  'text':
                      '''
[${data.jobTitle}]
• 회사: ${data.companyName}
• 위치: ${data.location}
• 급여: ${data.salary}
• 경력: 경력 ${data.career}년
• 고용형태: ${data.employmentType}
• 마감일: ${data.deadline}

하이어업 앱에서 더 많은 채용 정보를 확인하세요!''',
                });
              }),
              CircleAvatar(
                backgroundColor: grey.withAlpha(50),
                child: Center(child: BookmarkButton(id: data.id)),
              ),
            ],
          ),
          child: StatefulBuilder(
            builder: (context, set) {
              return Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            18.pa(
                              child: Card(
                                color: Colors.white,
                                child: 18.pa(
                                  child: Row(
                                    mainAxisAlignment: .center,
                                    children: [
                                      Column(
                                        spacing: 12,
                                        children: [
                                          Image.network(
                                            data.companyLogo,
                                            fit: .fitWidth,
                                            width: 100,
                                          ),

                                          Card(
                                            color: status.color,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: .circular(32),
                                            ),
                                            child: 8.pa(
                                              child: status.lebel.text(
                                                .new().b14.cw,
                                              ),
                                            ),
                                          ),

                                          data.jobTitle.text(.new().b18),

                                          IconButton(
                                            style: IconButton.styleFrom(
                                              padding: .symmetric(
                                                horizontal: 24,
                                              ),
                                              backgroundColor: grey.withAlpha(
                                                50,
                                              ),
                                            ),
                                            onPressed: () {
                                              '회사 상세 보기 서비스는 준비중에 있습니다.'.snack(
                                                context,
                                              );
                                            },
                                            icon: Row(
                                              spacing: 8,
                                              mainAxisSize: .min,
                                              children: [
                                                data.companyName.text(
                                                  .new().b14.cg,
                                                ),
                                                Icons.arrow_forward_ios.icon(
                                                  size: 12,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            12.pw(
                              child: Card(
                                color: Colors.white,
                                child: 18.pa(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          spacing: 8,
                                          children: [
                                            _iconButtonB(
                                              Icons.near_me_outlined,
                                              () {},
                                            ),
                                            data.location.text(.new().b14),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: 100,
                                        child: 22.ph(child: VerticalDivider()),
                                      ),

                                      Expanded(
                                        child: Column(
                                          spacing: 8,
                                          children: [
                                            _iconButtonB(
                                              Icons.near_me_outlined,
                                              () {},
                                            ),
                                            data.career.text(.new().b14),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: 100,
                                        child: 22.ph(child: VerticalDivider()),
                                      ),

                                      Expanded(
                                        child: Column(
                                          spacing: 8,
                                          children: [
                                            _iconButtonB(
                                              Icons.near_me_outlined,
                                              () {},
                                            ),
                                            data.salary.text(
                                              .new().b14,
                                              .center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SliverPadding(
                        padding: .symmetric(vertical: 18),
                        sliver: PinnedHeaderSliver(
                          child: Container(
                            color: Colors.white,
                            height: 60,
                            child: TabBar(
                              labelColor: blue,
                              unselectedLabelColor: grey,
                              indicatorColor: blue,
                              onTap: (value) {
                                set(() {
                                  page = value;
                                });
                              },
                              controller: controller,
                              tabs: [
                                '채용 정보',
                                '주요 업무',
                                '자격 요건',
                                '복리후생',
                              ].map((e) => Tab(child: e.text())).toList(),
                            ),
                          ),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: _Body(data: data, page: page),
                      ),
                    ],
                  ),

                  Align(
                    alignment: .bottomCenter,
                    child: Card(
                      color: Colors.white,
                      child: 12.pa(
                        child: Row(
                          spacing: 18,
                          children: [
                            Card(
                              color: Colors.white,
                              child: 4.pa(child: BookmarkButton(id: data.id)),
                            ),

                            Expanded(
                              child: PButton(
                                child: [
                                  Icons.send.icon(color: Colors.white),
                                  "지원하기".text(.new().b16.cw),
                                ],
                                tap: () {
                                  if (appCtrl.token.value == null) {
                                    LoginBottomSheet().show(context);
                                  } else {
                                    '지원 서비스는 준비중에 있습니다.'.snack(context);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key, required this.data, required this.page});

  final JobDetailModel data;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: SizedBox(
        height: 800,
        child: 18.pa(child: [page1(), page2(), page3(), page4()][page]),
      ),
    );
  }

  Widget page4() => _section(
    Icons.star,
    '복리후생',
    Wrap(
      spacing: 8,
      runSpacing: 8,
      children: data.benefits
          .map(
            (e) => Chip(
              color: .all(blue.withAlpha(30)),
              shape: RoundedRectangleBorder(borderRadius: .circular(32)),
              label: Row(
                mainAxisSize: .min,
                spacing: 4,
                children: [
                  Icons.star.icon(color: blue, size: 18),
                  e.text(.new().cb),
                ],
              ),
            ),
          )
          .toList(),
    ),
  );

  Widget page3() => _section(
    Icons.check_circle_outline,
    '자격 요건',
    Column(
      children: data.qualifications
          .map(
            (e) => Row(
              spacing: 12,
              children: [
                Card(
                  surfaceTintColor: Colors.green,
                  child: Icons.check.icon(color: Colors.green),
                ),

                Expanded(child: e.text(.new())),
              ],
            ),
          )
          .toList(),
    ),
  );

  Widget page2() => _section(
    Icons.work_outline,
    '주요 업무',
    Column(
      children: data.tasks.indexed
          .map(
            (e) => Row(
              spacing: 12,
              children: [
                Card(
                  color: blue,
                  child: SizedBox.square(
                    dimension: 35,
                    child: Center(child: e.$1.toString().text(.new().b14.cw)),
                  ),
                ),

                Expanded(child: e.$2.text(.new())),
              ],
            ),
          )
          .toList(),
    ),
  );

  Widget page1() => Column(
    spacing: 12,
    children: [
      _section(
        Icons.description_outlined,
        '직무 정보',
        Card(
          surfaceTintColor: grey,
          child: 12.pa(
            child: Column(
              spacing: 8,
              children:
                  [
                        (Icons.work_outline, '직무', data.jobTitle),
                        (
                          Icons.description_outlined,
                          '고용형태',
                          data.employmentType,
                        ),
                        (Icons.calendar_month_outlined, '마감일', data.deadline),
                      ]
                      .map(
                        (e) => Row(
                          spacing: 12,
                          children: [
                            e.$1.icon(color: grey, size: 28),

                            e.$2.text(.new().b14.cg),

                            Spacer(),

                            Card(
                              color: Colors.white,
                              child: 8.pa(child: e.$3.text(.new().b14)),
                            ),
                          ],
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
      ),
      _section(
        Icons.description_outlined,
        '포지션 소개',
        data.positionIntro.text(.new().cg),
      ),
    ],
  );
}

Widget _section(IconData icon, String t, Widget child) => Column(
  spacing: 12,
  children: [
    Row(
      spacing: 12,
      children: [
        Card(
          surfaceTintColor: blue,
          child: 8.pa(child: icon.icon(color: blue, size: 24)),
        ),

        t.text(.new().b18),
      ],
    ),

    child,
  ],
);

Widget _iconButtonG(IconData icon, VoidCallback tap) => IconButton(
  style: IconButton.styleFrom(backgroundColor: grey.withAlpha(30)),
  onPressed: tap,
  icon: icon.icon(color: grey, size: 24),
);

Widget _iconButtonB(IconData icon, VoidCallback tap) => IconButton(
  style: IconButton.styleFrom(backgroundColor: blue.withAlpha(30)),
  onPressed: tap,
  icon: icon.icon(color: blue, size: 24),
);
