import 'package:flutter/material.dart';
import 'package:hire_up_poc_2/app_ctrl.dart';
import 'package:hire_up_poc_2/utils.dart';
import 'package:hire_up_poc_2/widgets/base_scaffold.dart';
import 'package:hire_up_poc_2/widgets/job_card.dart';
import 'package:hire_up_poc_2/widgets/login_bottom_sheet.dart';

class JobBookScreen extends StatelessWidget {
  const JobBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: 18.pw(
        child: ValueListenableBuilder(
          valueListenable: appCtrl.user,
          builder: (context, value, child) => Column(
            children: [
              18.ph(
                child: Row(children: [BackButton(), '관심 공고'.text(.new().b18)]),
              ),

              Expanded(
                child: appCtrl.user.value == null
                    ? Center(
                        child: Column(
                          mainAxisSize: .min,
                          spacing: 18,
                          children: [
                            Icons.lock_outline.icon(size: 58, color: grey),
                            '로그인이 필요합니다'.text(.new().b18),
                            '로그인 후 관심 공고를 확인할 수 있어요'.text(.new().b16.cg),

                            AppButton.primaru(
                              () {
                                LoginBottomSheet().show(context);
                              },
                              '로그인',
                              padding: 48,
                            ),
                          ],
                        ),
                      )
                    : ValueListenableBuilder(
                        valueListenable: appCtrl.bookmarkList,
                        builder: (context, value, child) => FutureBuilder(
                          future: appCtrl.loadJobList(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == .waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            final list = (snapshot.data ?? [])
                              ..removeWhere(
                                (element) => !value.contains(element.id),
                              );

                            if (list.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisSize: .min,
                                  spacing: 18,
                                  children: [
                                    Icons.bookmark_outline.icon(
                                      size: 58,
                                      color: grey,
                                    ),
                                    '관심 공고가 없습니다.'.text(.new().b18),
                                    '관심있는 공고를 등록해 보세요.'.text(.new().b16.cg),
                                  ],
                                ),
                              );
                            }

                            return SingleChildScrollView(
                              child: Column(
                                spacing: 12,
                                children: list.map((e) {
                                  double x = 0;
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return GestureDetector(
                                        onHorizontalDragUpdate: (details) {
                                          setState(() {
                                            x = (x + details.delta.dx).clamp(
                                              -60,
                                              0,
                                            );
                                          });
                                        },
                                        onHorizontalDragEnd: (details) {
                                          if (x <= -50) {
                                            appCtrl.bookmark(e.id);
                                          }
                                        },
                                        child: Transform.translate(
                                          offset: .new(x, 0),
                                          child: JobCard(
                                            model: e,
                                            tap: () {
                                              '상세 공고 페이지 서비스는 현재 구현중에 있습니다.'
                                                  .snack(context);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
