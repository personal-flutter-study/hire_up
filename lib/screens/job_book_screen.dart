import 'package:flutter/material.dart';
import 'package:hire_up_poc_4/app_ctrl.dart';
import 'package:hire_up_poc_4/widgets/base_scaffold.dart';
import 'package:hire_up_poc_4/widgets/login_bottom_sheet.dart';

import '../utils.dart';
import '../widgets/job_card.dart';

class JobBookScreen extends StatefulWidget {
  const JobBookScreen({super.key});

  @override
  State<JobBookScreen> createState() => _JobBookScreenState();
}

class _JobBookScreenState extends State<JobBookScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appCtrl.user,
      builder: (context, value, child) => BaseScaffold(
        appBar: AppBar(title: '관심 공고'.text(style: .new().b18)),
        child: appCtrl.user.value == null
            ? Center(
                child: Column(
                  mainAxisAlignment: .center,
                  spacing: 12,
                  children: [
                    Icons.lock_outline.icon(size: 58, color: grey),
                    '로그인이 필요합니다'.text(style: .new().b16),
                    '로그인 후 관심 공고를 확인할 수 있어요'.text(style: .new().cg),

                    12.sh(),

                    120.pw(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: .circular(12),
                          ),
                          padding: .symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          LoginBottomSheet().show(context);
                        },
                        child: Row(
                          mainAxisAlignment: .center,
                          children: ['로그인'.text(style: .new().b16.cw)],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : FutureBuilder(
                future: appCtrl.loadJobList(context),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState == .waiting)
                    return Center(child: CircularProgressIndicator());

                  return ValueListenableBuilder(
                    valueListenable: appCtrl.bookmarks,
                    builder: (context, value, child) {
                      final data = asyncSnapshot.data
                        ?..removeWhere(
                          (element) => !value.contains(element.id),
                        );

                      if (data == null || data.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: .center,
                            spacing: 12,
                            children: [
                              Icons.bookmark_outline.icon(
                                size: 58,
                                color: grey,
                              ),
                              '북마크 공고가 없습니다.'.text(style: .new().b16),
                            ],
                          ),
                        );
                      }

                      return 18.pa(
                        child: SingleChildScrollView(
                          child: Column(
                            spacing: 12,
                            children: (asyncSnapshot.data ?? []).map((e) {
                              double x = 0;
                              return StatefulBuilder(
                                builder: (context, set) {
                                  return GestureDetector(
                                    onHorizontalDragUpdate: (details) {
                                      set(() {
                                        x = (x + details.delta.dx).clamp(
                                          -100,
                                          0,
                                        );
                                      });
                                    },
                                    onHorizontalDragEnd: (details) {
                                      if (x <= -80) {
                                        appCtrl.bookmark(e.id);
                                      }
                                    },
                                    child: Transform.translate(
                                      offset: Offset(x, 0),
                                      child: JobCard(
                                        model: e,
                                        tap: () {
                                          '관심 공공 상세 페이지는 준비중에 있습니다.'.snack(
                                            context,
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
