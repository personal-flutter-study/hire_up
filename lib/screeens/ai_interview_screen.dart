import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/screeens/ai_interview_choose_screen.dart';
import 'package:hire_up_poc_1/widgets/base_scaffold.dart';
import 'package:hire_up_poc_1/widgets/utils.dart';






class AiInterviewScreen extends StatefulWidget {
  const AiInterviewScreen({super.key, required this.interviewCtrl});

  final InterviewCtrl interviewCtrl;

  @override
  State<AiInterviewScreen> createState() => _AiInterviewScreenState();
}

class _AiInterviewScreenState extends State<AiInterviewScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      color: Colors.white,
      child: 18.pw(
        Column(
          crossAxisAlignment: .start,
          children: [
            12.ph(
              Row(
                children: [
                  AppImg.app_icon.image(size: 80),
                  Expanded(child: Center(child: 'AI 모의 면접'.text(.new().b18))),
                  Card(
                    color: Colors.white,
                    child: 8.pa('면접 종료'.text(.new().b16)),
                  ),
                ],
              ),
            ),

            '${widget.interviewCtrl.field?.label}  면접'.text(.new().b24),

            Row(children: []),
          ],
        ),
      ),
    );
  }
}
