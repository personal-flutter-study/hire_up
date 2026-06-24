import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/controllers/app_ctrl.dart';
import 'package:hire_up_poc_1/main.dart';
import 'package:hire_up_poc_1/models/interview_model.dart';
import 'package:hire_up_poc_1/models/question_model.dart';
import 'package:hire_up_poc_1/screeens/ai_interview_choose_screen.dart';
import 'package:hire_up_poc_1/widgets/base_scaffold.dart';
import 'package:hire_up_poc_1/widgets/sound_wave_widget.dart';
import 'package:hire_up_poc_1/widgets/utils.dart';
import 'package:video_player/video_player.dart';

class AiInterviewScreen extends StatefulWidget {
  const AiInterviewScreen({super.key});

  @override
  State<AiInterviewScreen> createState() => _AiInterviewScreenState();
}

class _AiInterviewScreenState extends State<AiInterviewScreen> {
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer(Duration(seconds: 1), () {
      interviewCtrl.sec++;
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      color: Colors.white,
      child: 18.pw(
        ListenableBuilder(
          listenable: Listenable.merge([
            interviewCtrl.questions,
            interviewCtrl.index,
          ]),
          builder: (context, child) {
            print(interviewCtrl.index.value);
            return Column(
              crossAxisAlignment: .start,
              children: [
                12.ph(
                  Row(
                    children: [
                      AppImg.app_icon.image(size: 80),
                      Expanded(
                        child: Center(child: 'AI 모의 면접'.text(.new().b18)),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => SimpleDialog(
                              backgroundColor: Colors.white,
                              title: '면접 종료'.text(.new().b24),
                              contentPadding: .symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              children: [
                                '면접을 종료하시겠습니까?\n녹음된 내용은 저장됩니다.'.text(
                                  .new().b14,
                                ),

                                12.sh,

                                Row(
                                  mainAxisAlignment: .end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        context.back();
                                      },
                                      child: '취소'.text(.new().b14),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        appCtrl.saveInterview(
                                          InterviewModel(
                                            type:
                                                interviewCtrl.type.value.label,
                                            sec: interviewCtrl.sec,
                                            date: DateTime.now(),
                                          ),
                                        );
                                        context.back().pop();
                                      },
                                      child: '종료'.text(
                                        TextStyle(color: Colors.redAccent).b14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          child: 8.pa('면접 종료'.text(.new().b16)),
                        ),
                      ),
                    ],
                  ),
                ),

                '${interviewCtrl.jobRole?.label}  면접'.text(.new().b24),

                12.ph(
                  Row(
                    spacing: 18,
                    children: [
                      '질문 ${interviewCtrl.index.value + 1} / ${interviewCtrl.total}'
                          .text(.new().b14.cg),
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: .circular(32),
                            color: grey.withAlpha(100),
                          ),
                          child: FractionallySizedBox(
                            alignment: .centerLeft,
                            widthFactor:
                                ((interviewCtrl.index.value + 1) /
                                        interviewCtrl.total)
                                    .clamp(0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: .circular(32),
                                color: blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: _Body(
                    key: ValueKey(interviewCtrl.index.value),
                    model: interviewCtrl.question,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({super.key, required this.model});

  final QuestionModel model;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late VideoPlayerController videoPlayer;

  final _wave = List.generate(40, (index) => Random().nextInt(10) * .1);

  double get progress {
    final duration = videoPlayer.value.duration.inMilliseconds;
    final position = videoPlayer.value.position.inMilliseconds;
    if (duration == 0) return 0;
    return position / duration;
  }

  @override
  void initState() {
    print(widget.model.audioUrl);
    videoPlayer = VideoPlayerController.networkUrl(
      Uri.parse(widget.model.audioUrl),
    )..addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      print(widget.model.audioUrl);
      videoPlayer.initialize().then((value) {
        videoPlayer.play();
      });

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(progress);

    bool isCompleted = videoPlayer.value.isCompleted;

    final playT = isCompleted ? '재생 완료' : '질문 듣는 중';

    return Column(
      children: [
        Expanded(
          child: Card(
            color: blueL,
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Center(child: AppImg.avatar_base.image(size: 200)),

                      Center(
                        child: Transform.translate(
                          offset: .new(0, 10),
                          child: switch (_wave[(progress * (_wave.length - 1))
                              .toInt()]) {
                            < .2 => AppImg.lv0_mouth_closed.image(size: 20),
                            < .4 => AppImg.lv1_mouth_small.image(size: 20),
                            < .6 => AppImg.lv2_mouth_medium.image(size: 20),
                            < .8 => AppImg.lv3_mouth_large.image(size: 20),
                            _ => AppImg.lv0_mouth_closed.image(size: 20),
                          },
                        ),
                      ),

                      Align(
                        alignment: Alignment(.5, -.3),
                        child: Card(
                          color: blue,
                          child: 4.pw(6.pa('AI'.text(.new().b14.cw))),
                        ),
                      ),
                    ],
                  ),
                ),

                _bottomCard(),
              ],
            ),
          ),
        ),

        Center(
          child: Card(
            margin: .symmetric(vertical: 18),
            color: blueL,
            shape: RoundedRectangleBorder(borderRadius: .circular(32)),
            child: 8.pa(4.pw(playT.text(.new().b14.cb))),
          ),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: .circular(12)),
            backgroundColor: blue,
            padding: .symmetric(vertical: 16, horizontal: 0),
          ),
          onPressed: () {
            if (interviewCtrl.index.value >= interviewCtrl.total - 1) {
              appCtrl.saveInterview(
                InterviewModel(
                  type: interviewCtrl.type.value.label,
                  date: DateTime.now(),
                  sec: interviewCtrl.sec,
                ),
              );
              print(interviewCtrl.index.value >= interviewCtrl.total);
              showDialog(
                context: context,
                builder: (context) => SimpleDialog(
                  backgroundColor: Colors.white,
                  contentPadding: .symmetric(horizontal: 24, vertical: 12),
                  title: Row(
                    spacing: 8,
                    children: [
                      Icons.check_circle_outline.icon(color: green, size: 24),
                      '면접 완료'.text(.new().b24),
                    ],
                  ),
                  children: [
                    '${interviewCtrl.total}개의 질문에 답변하셨습니다.'.text(.new().b14),

                    Row(
                      children: [
                        Icons.mic.icon(color: green, size: 24),
                        '녹음이 저장되었습니다.'.text(.new().b14),
                      ],
                    ),

                    12.sh,

                    Row(
                      mainAxisAlignment: .end,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.back().pop();
                          },
                          child: '확인'.text(.new().b14.cb),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              interviewCtrl.next();
            }
          },
          child: Row(
            mainAxisAlignment: .center,
            spacing: 8,
            children: [
              Text(
                interviewCtrl.index.value >= interviewCtrl.total - 1
                    ? '면접 완료'
                    : '다음 질문',
                style: TextStyle(color: Colors.white).b16,
              ),
              if (interviewCtrl.index.value < interviewCtrl.total - 1)
                Icons.arrow_forward.icon(color: Colors.white),
            ],
          ),
        ),

        18.sh,
      ],
    );
  }

  Widget _bottomCard() {
    final playT = progress == 1.0 ? '답변해주세요' : '면접관 질문 재생 중...';

    return SizedBox(
      height: 200,
      child: Card(
        margin: .zero,
        color: Colors.white,
        child: Column(
          mainAxisSize: .min,
          children: [
            8.pa(
              Row(
                spacing: 8,
                children: [
                  Card(
                    color: blue,
                    child: 10.pa(
                      Icons.volume_up.icon(size: 24, color: Colors.white),
                    ),
                  ),

                  playT.text(.new()),

                  Spacer(),

                  '${videoPlayer.value.position.toMMSS} / ${videoPlayer.value.duration.toMMSS}'
                      .text(.new().b14.cg),
                ],
              ),
            ),

            12.pw(
              ClipRect(
                clipBehavior: .hardEdge,
                child: SoundWaveWidget(volumes: _wave, filled: progress),
              ),
            ),

            Divider(),

            Expanded(
              child: Row(
                children: [
                  16.pa('Q.'.text(.new().b14.cb)),
                  Expanded(child: widget.model.questionText.text(.new().b14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
