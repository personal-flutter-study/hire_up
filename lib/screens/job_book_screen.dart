import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/app_ctrl.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';
import 'package:hire_up_poc_3/widgets/job_card.dart';
import 'package:hire_up_poc_3/widgets/login_bottom_sheet.dart';
import 'package:hire_up_poc_3/widgets/p_button.dart';

class JobBookScreen extends StatefulWidget {
  const JobBookScreen({super.key});

  @override
  State<JobBookScreen> createState() => _JobBookScreenState();
}

class _JobBookScreenState extends State<JobBookScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: '관심 공고'.text(.new().b18)),
      child: ValueListenableBuilder(
        valueListenable: appCtrl.token,
        builder: (context, value, child) {
          if (value == null) {
            return Center(
              child: Column(
                spacing: 8,
                mainAxisAlignment: .center,
                children: [
                  Icons.lock_outline.icon(size: 88, color: grey),
                  '로그인이 필요합니다'.text(.new().b18),
                  '로그인 후 관심 공고를 확인할 수 있어요'.text(.new().b16.cg),
                  12.sh,
                  100.pw(
                    child: PButton(
                      child: ['로그인'.text(.new().b16.cw)],
                      tap: () {
                        LoginBottomSheet().show(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return FutureBuilder(
            future: appCtrl.loadJobList(context),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == .waiting)
                return Center(child: CircularProgressIndicator());

              return ValueListenableBuilder(
                valueListenable: appCtrl.bookmarks,
                builder: (context, value, child) {
                  final data = (asyncSnapshot.data ?? [])
                    ..removeWhere(
                      (element) =>
                          !appCtrl.bookmarks.value.contains(element.id),
                    );

                  if (data.isEmpty) {
                    return Center(
                      child: Column(
                        spacing: 8,
                        mainAxisAlignment: .center,
                        children: [
                          Icons.bookmark_border_outlined.icon(
                            size: 88,
                            color: grey,
                          ),
                          '관심 공고가 없습니다.'.text(.new().b18),
                          '흥미가 가는 공고를 북마크 해보세요.'.text(.new().b16.cg),
                        ],
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: 18.pw(
                      child: Column(
                        children: data.map((e) {
                          double x = 0;

                          return StatefulBuilder(
                            builder: (context, set) => GestureDetector(
                              onHorizontalDragUpdate: (details) {
                                set(() {
                                  x = (x + details.delta.dx).clamp(-80, 0);
                                });
                              },
                              onHorizontalDragEnd: (details) {
                                if (x <= -60) {
                                  appCtrl.bookmark(e.id);
                                } else {
                                  set(() {
                                    x = 0;
                                  });
                                }
                              },
                              child: Transform.translate(
                                offset: .new(x, 0),
                                child: JobCard(
                                  model: e,
                                  tap: () {
                                    '공고 상세 페이지는 현재 준비중에 있습니다.'.snack(context);
                                  },
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
