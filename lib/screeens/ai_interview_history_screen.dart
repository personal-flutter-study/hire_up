import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/controllers/app_ctrl.dart';
import 'package:hire_up_poc_1/main.dart';
import 'package:hire_up_poc_1/models/interview_model.dart';
import 'package:hire_up_poc_1/widgets/base_scaffold.dart';
import 'package:hire_up_poc_1/widgets/utils.dart';
import 'package:intl/intl.dart';

class AiInterviewHistoryScreen extends StatefulWidget {
  const AiInterviewHistoryScreen({super.key});

  @override
  State<AiInterviewHistoryScreen> createState() =>
      _AiInterviewHistoryScreenState();
}

class _AiInterviewHistoryScreenState extends State<AiInterviewHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: '이전 면접 기록'.text(.new().b18),
        centerTitle: true,
      ),
      child: SingleChildScrollView(
        child: 18.pw(
          Column(
            children: appCtrl
                .loadInterview()
                .map((e) => _InterviewCard(model: e))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _InterviewCard extends StatefulWidget {
  const _InterviewCard({super.key, required this.model});

  final InterviewModel model;

  @override
  State<_InterviewCard> createState() => _InterviewCardState();
}

class _InterviewCardState extends State<_InterviewCard> {
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: isSelect ? blue : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(12),
        side: BorderSide(color: isSelect ? blue : Colors.white),
      ),
      color: Colors.white,
      child: 18.pa(
        Row(
          spacing: 12,
          children: [
            IconButton(
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: .circular(12)),
                backgroundColor: isSelect ? blue : blueL,
              ),
              onPressed: () {
                setState(() {
                  isSelect = !isSelect;
                });
              },
              icon: Icon(
                color: isSelect ? Colors.white : blue,
                isSelect ? Icons.pause : Icons.play_arrow,
                size: 24,
              ),
            ),
            Column(
              crossAxisAlignment: .start,
              children: [
                widget.model.type.text(.new().b16),
                DateFormat(
                  'yyyy.MM.dd hh:mm',
                ).format(widget.model.date).text(.new().b14.cg),
              ],
            ),

            Spacer(),

            DateFormat('mm:ss')
                .format(DateTime(0, 0, 0, 0, 0, widget.model.sec))
                .text(.new().b16.cg),
          ],
        ),
      ),
    );
  }
}
