import 'package:flutter/material.dart';
import 'package:hire_up_poc_5/app_ctrl.dart';
import 'package:hire_up_poc_5/utils.dart';
import 'package:hire_up_poc_5/widgets/base_scaffold.dart';
import 'package:hire_up_poc_5/widgets/job_card.dart';
import 'package:hire_up_poc_5/widgets/login_bottom.dart';

class JobBookScreen extends StatefulWidget {
  const JobBookScreen({super.key});

  @override
  State<JobBookScreen> createState() => _JobBookScreenState();
}

class _JobBookScreenState extends State<JobBookScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        leading: Icons.arrow_back_ios.iButton(() {
          context.back();
        }),
        title: '관심 공고'.text(TextStyle().b24),
      ),
      child: ListenableBuilder(
        listenable: appCtrl.ticker,
        builder: (context, child) {
          if (appCtrl.token.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: .center,
                spacing: 12,
                children: [
                  Icons.lock_outline.icon(size: 78, color: grey),

                  '로그인이 필요합니다'.text(TextStyle().b20),
                  '로그인 후 관심 공고를 확인할 수 있어요'.text(TextStyle(fontSize: 16)),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: .symmetric(vertical: 16),
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: .circular(12),
                      ),
                    ),
                    onPressed: () {
                      LoginBottom().show(context);
                    },
                    child: 78.pw(child: '로그인'.text(TextStyle().b16.cw)),
                  ),
                ],
              ),
            );
          }

          return 18.pa(
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: appCtrl.loadJobs(context),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState == .waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final data = asyncSnapshot.data
                    ?..removeWhere(
                      (element) => !appCtrl.bookmarks.contains(element.id),
                    );

                  if (data == null || data.isEmpty) {
                    return Center(child: '조회할 수 없습니다.'.text(TextStyle().b24));
                  }

                  return Column(
                    children: data.map((e) {
                      double x = 0;
                      return StatefulBuilder(
                        builder: (context, set) {
                          return GestureDetector(
                            onHorizontalDragUpdate: (details) {
                              set(() {
                                x = (x + details.delta.dx).clamp(-120, 0);
                              });
                            },
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Container(
                                    margin: .all(8),
                                    color: Colors.red,
                                    child: Align(
                                      alignment: .centerRight,
                                      child: 18.pw(
                                        child: Icons.delete.iButton(() {
                                          appCtrl.bookmark(e.id);
                                        }, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),

                                Transform.translate(
                                  offset: .new(x, 0),
                                  child: JobCard(
                                    model: e,
                                    tap: () {
                                      '중비중 입니다.'.toast();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
