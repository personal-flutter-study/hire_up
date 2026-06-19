import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/controllers/app_ctrl.dart';
import 'package:hire_up_poc_1/models/job_detail_model.dart';
import 'package:hire_up_poc_1/widgets/base_scaffold.dart';
import 'package:hire_up_poc_1/widgets/login_bottom_sheet.dart';
import 'package:hire_up_poc_1/widgets/utils.dart';
import 'package:http/http.dart';

import '../main.dart';

final _jobCtrl = _JobCtrl();

class _JobCtrl {
  Future<JobDetailModel?> loadJobDetail(
    BuildContext context, {
    required int id,
  }) async {
    final res = await get(Uri.parse('$baseUrl/jobs/$id'));

    if (res.statusCode == 200) {
      print('공고 상세 조회 성공');
      print(jsonDecode(res.body)['data']);
      return JobDetailModel.fromJson(jsonDecode(res.body)['data']);
    }

    '공고 상세 조회 서버 통신 오류'.snack(context);

    return null;
  }

  Future<void> share(BuildContext context, JobDetailModel model) async {
    final success = await platformM.invokeMethod('share', {
      'text':
          """
[${model.jobTitle}]
• 회사: ${model.companyName}
• 위치: ${model.location}
• 급여: ${model.salary}
• 경력: 경력 ${model.career}년
• 고용형태: ${model.employmentType}
• 마감일: ${model.deadline}
하이어업 앱에서 더 많은 채용 정보를 확인하세요!""",
    });

    if (success) {
      '공유 성공'.snack(context);
    } else {
      '공유 실패'.snack(context);
    }
  }
}

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: FutureBuilder(
        future: _jobCtrl.loadJobDetail(context, id: id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == .waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null) {
            return Center(
              child: Column(
                mainAxisAlignment: .center,
                children: ['해당 공고는 조회할 수 없습니다.'.text(.new().b18), BackButton()],
              ),
            );
          }

          final model = snapshot.data!;

          return ValueListenableBuilder(
            valueListenable: appCtrl.bookmarkList,
            builder: (context, value, child) => Column(
              children: [
                Expanded(child: _Body(model: model)),
                ColoredBox(
                  color: Colors.white,
                  child: 18.pa(
                    Row(
                      spacing: 12,
                      children: [
                        Card(
                          color: Colors.white,
                          elevation: 6,
                          child: 12.pa(AppButton.bookmark(context, model.id)),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: .circular(12),
                              ),
                              backgroundColor: blue,
                              padding: .symmetric(vertical: 16),
                            ),
                            onPressed: () {
                              if (appCtrl.user.value == null) {
                                LoginBottomSheet().show(context);
                              } else {
                                '지원하기 서비스는 현재 준비중에 있습니다.'.snack(context);
                              }
                            },
                            child: Row(
                              spacing: 12,
                              mainAxisAlignment: .center,
                              children: [
                                Icons.send.icon(color: Colors.white),
                                Text(
                                  '지원하기',
                                  style: TextStyle(color: Colors.white).b18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Top extends StatelessWidget {
  const _Top({required this.model});

  final JobDetailModel model;

  @override
  Widget build(BuildContext context) {
    return 12.pa(
      Column(
        spacing: 12,
        children: [
          Card(
            color: Colors.white,
            child: SizedBox(
              width: .infinity,
              child: 24.ph(
                Column(
                  spacing: 12,
                  children: [
                    Image.network(
                      model.companyLogo,
                      fit: .fitWidth,
                      width: 100,
                    ),

                    Card(
                      color: model.recruitStatus.color,
                      child: Padding(
                        padding: .symmetric(horizontal: 12, vertical: 6),
                        child: model.recruitStatus.label.text(
                          TextStyle(color: Colors.white).b14,
                        ),
                      ),
                    ),

                    model.jobTitle.text(.new().b18),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: .min,
                        spacing: 2,
                        children: [
                          Text(model.companyName, style: TextStyle().b14.cg),
                          Icons.arrow_forward_ios.icon(color: grey),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Card(
            color: Colors.white,
            child: 18.pa(
              12.ph(
                Row(
                  children: [
                    _info(Icons.near_me_outlined, model.location),
                    SizedBox(
                      height: 32,
                      child: VerticalDivider(thickness: 1.5),
                    ),
                    _info(Icons.work_outline, model.career),
                    SizedBox(
                      height: 32,
                      child: VerticalDivider(thickness: 1.5),
                    ),
                    _info(Icons.calendar_month, model.salary),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _info(IconData icon, String m) => Expanded(
    child: Column(
      spacing: 8,
      mainAxisAlignment: .center,
      children: [
        icon.button(
          () {},
          style: IconButton.styleFrom(backgroundColor: blueL),
          color: blue,
        ),
        m.text(.new().b14, align: .center),
      ],
    ),
  );
}

class _Body extends StatefulWidget {
  const _Body({required this.model});

  final JobDetailModel model;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with TickerProviderStateMixin {
  int page = 0;

  late final TabController controller;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        PinnedHeaderSliver(
          child: ColoredBox(
            color: Colors.white,
            child: 8.pa(
              Row(
                spacing: 8,
                children: [
                  Icons.arrow_back_ios.button(() {
                    context.back();
                  }, style: .new().cg),

                  Spacer(),

                  Icons.ios_share_outlined.button(() {
                    _jobCtrl.share(context, widget.model);
                  }, style: .new().cg),

                  (appCtrl.bookmarkList.value.contains(widget.model.id)
                          ? Icons.bookmark
                          : Icons.bookmark_border_outlined)
                      .button(
                        () {
                          if (appCtrl.user.value == null) {
                            LoginBottomSheet().show(context);
                          } else {
                            appCtrl.bookmark(widget.model.id);
                          }
                        },
                        style: .new().cg,
                        color:
                            appCtrl.bookmarkList.value.contains(widget.model.id)
                            ? blue
                            : grey,
                      ),
                ],
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(child: _Top(model: widget.model)),

        PinnedHeaderSliver(
          child: ColoredBox(
            color: Colors.white,
            child: TabBar(
              indicatorColor: blue,
              unselectedLabelColor: grey,
              labelColor: blue,
              onTap: (value) {
                setState(() {
                  page = value;
                });

                print(page);
              },
              controller: controller,
              tabs: [
                "채용 정보",
                "주요 업무",
                "자격 요건",
                "복리후생",
              ].map((e) => Tab(text: e, height: 58)).toList(),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: ConstrainedBox(
            constraints: .new(minHeight: 800),
            child: [
              _tap(
                Column(
                  spacing: 12,
                  children: [
                    _section(
                      Icons.description_outlined,
                      '직무 정보',
                      Card(
                        color: greyL,
                        child: 12.ph(
                          Column(
                            children:
                                [
                                      (
                                        Icons.work_outline,
                                        '직무',
                                        widget.model.jobTitle,
                                      ),
                                      (
                                        Icons.description_outlined,
                                        '고용형태',
                                        widget.model.employmentType,
                                      ),
                                      (
                                        Icons.calendar_month_outlined,
                                        '마감일',
                                        widget.model.deadline,
                                      ),
                                    ]
                                    .map(
                                      (e) => 12.pa(
                                        Row(
                                          spacing: 12,
                                          children: [
                                            e.$1.icon(color: grey, size: 28),
                                            e.$2.text(.new().b14.cg),
                                            Spacer(),
                                            Card(
                                              color: Colors.white,
                                              child: 4.pa(
                                                e.$3.text(.new().b14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                      ),
                    ),
                    _section(
                      Icons.report_outlined,
                      '포지션 소개',
                      widget.model.positionIntro.text(.new().b14.cg),
                    ),
                  ],
                ),
              ),

              _tap(
                _section(
                  Icons.work_outline,
                  '주요 업무',
                  Column(
                    spacing: 12,
                    children: widget.model.tasks.indexed
                        .map(
                          (e) => Row(
                            spacing: 12,
                            children: [
                              Card(
                                color: blue,
                                child: SizedBox.square(
                                  dimension: 32,
                                  child: Center(
                                    child: '${e.$1 + 1}'.text(
                                      TextStyle(color: Colors.white).b14,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(child: e.$2.text(.new().b14.cg)),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),

              _tap(
                _section(
                  Icons.check_circle_outline,
                  '자격 요건',
                  Column(
                    spacing: 12,
                    children: widget.model.qualifications
                        .map(
                          (e) => Row(
                            spacing: 12,
                            children: [
                              Card(
                                shape: CircleBorder(),
                                color: greenL,
                                child: 4.pa(
                                  Icons.check.icon(color: green, size: 18),
                                ),
                              ),
                              Expanded(child: e.text(.new().b14.cg)),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),

              _tap(
                _section(
                  Icons.star_border,
                  '복리후생',
                  SizedBox(
                    width: .infinity,
                    child: Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: widget.model.benefits
                          .map(
                            (e) => Chip(
                              color: .all(blueL),
                              shape: RoundedRectangleBorder(
                                borderRadius: .circular(32),
                              ),
                              label: Row(
                                mainAxisSize: .min,
                                children: [
                                  Icons.star.icon(color: blue, size: 16),
                                  e.text(TextStyle(color: blue).b14),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ][page],
          ),
        ),
      ],
    );
  }

  Widget _tap(Widget child) =>
      18.pa(Card(color: Colors.white, child: 18.pa(child)));

  Widget _section(IconData icon, String m, Widget page) => Column(
    children: [
      Row(
        children: [
          icon.button(
            () {},
            style: IconButton.styleFrom(backgroundColor: blueL),
            color: blue,
          ),
          m.text(.new().b16),
        ],
      ),

      18.sh,

      page,
    ],
  );
}
