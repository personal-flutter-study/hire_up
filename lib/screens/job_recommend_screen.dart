import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/app_ctrl.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';
import 'package:hire_up_poc_3/widgets/job_card.dart';

class JobRecommendScreen extends StatefulWidget {
  const JobRecommendScreen({super.key});

  @override
  State<JobRecommendScreen> createState() => _JobRecommendScreenState();
}

class _JobRecommendScreenState extends State<JobRecommendScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: '오늘의 추천 공고 ✨'.text(.new().b18)),
      child: 18.pw(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: appCtrl.loadRecommendJobList(context),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == .waiting)
                return Center(child: CircularProgressIndicator());

              return Column(
                children: (asyncSnapshot.data ?? [])
                    .map((e) => JobCard(model: e.toJobModel()))
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
