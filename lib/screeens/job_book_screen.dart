import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/controllers/app_ctrl.dart';
import 'package:hire_up_poc_1/main.dart';
import 'package:hire_up_poc_1/widgets/base_scaffold.dart';
import 'package:hire_up_poc_1/widgets/job_card.dart';
import 'package:hire_up_poc_1/widgets/login_bottom_sheet.dart';

import '../widgets/utils.dart';

class JobBookScreen extends StatefulWidget {
  const JobBookScreen({super.key});

  @override
  State<JobBookScreen> createState() => _JobBookScreenState();
}

class _JobBookScreenState extends State<JobBookScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: 18.pw(
        Column(
          children: [
            18.ph(
              Row(
                spacing: 8,
                children: [
                  IconButton(
                    onPressed: () {
                      context.back();
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),

                  Text('관심 공고', style: TextStyle().b16),
                ],
              ),
            ),

            8.sh,

            Expanded(
              child: ValueListenableBuilder(
                valueListenable: appCtrl.user,
                builder: (context, value, child) {
                  if (value != null) {
                    return _Body();
                  } else {
                    return Column(
                      mainAxisAlignment: .center,
                      children: [
                        AppIcon.bookmark.icon(size: 58, color: grey),
                        8.ph(Text('로그인이 필요합니다', style: TextStyle().b16)),
                        Text(
                          '로그인 후 관심 공고를 확인할 수 있어요',
                          style: TextStyle().b14.cg,
                        ),

                        18.sh,

                        AppButton.primary(' 로그인', () {
                          LoginBottomSheet().show(context);
                        }, padding: 58),
                      ],
                    );
                  }
                },
              ),
            ),
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: appCtrl.loadJobList(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == .waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return ValueListenableBuilder(
          valueListenable: appCtrl.bookmarkList,
          builder: (context, value, child) {
            final jobs = (snapshot.data ?? []).where(
              (element) => appCtrl.bookmarkList.value.contains(element.id),
            );

            return jobs.isEmpty
                ? Column(
                    mainAxisAlignment: .center,
                    children: [
                      AppIcon.bookmark.icon(size: 58, color: grey),
                      8.ph(Text('관심 공고가 없습니다', style: TextStyle().b16.cg)),
                      Text('관심 있는 공고를 추가해 보세요', style: TextStyle().b14.cg),
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      spacing: 12,
                      children: jobs.map((e) {
                        double x = 0;

                        return StatefulBuilder(
                          builder: (context, setState) => GestureDetector(
                            onHorizontalDragUpdate: (details) {
                              x = (x + details.delta.dx).clamp(-60, 0);
                              setState(() {});
                            },
                            onHorizontalDragEnd: (details) {
                              if (x < -50) {
                                appCtrl.bookmarkList.value.remove(e.id);
                                appCtrl.bookmarkList.value = List.of(
                                  appCtrl.bookmarkList.value,
                                );
                              }
                            },
                            child: Transform.translate(
                              offset: .new(x, 0),
                              child: JobCard(
                                model: e,
                                tap: () {
                                  '상세 관심 공고 서비스는 현재 준비중에 있습니다.'.snack(context);
                                },
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
          },
        );
      },
    );
  }
}
