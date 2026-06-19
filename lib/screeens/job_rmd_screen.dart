import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/controllers/app_ctrl.dart';
import 'package:hire_up_poc_1/widgets/base_scaffold.dart';
import 'package:hire_up_poc_1/widgets/job_card.dart';
import 'package:hire_up_poc_1/widgets/utils.dart';

class JobRmdScreen extends StatefulWidget {
  const JobRmdScreen({super.key});

  @override
  State<JobRmdScreen> createState() => _JobRmdScreenState();
}

class _JobRmdScreenState extends State<JobRmdScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: 18.pw(
        Column(
          children: [
            18.ph(
              Row(
                children: [
                  AppButton.back(context),
                  24.sw,
                  '오늘의 추천 공고 ✨'.text(TextStyle().b18),
                ],
              ),
            ),

            24.sh,

            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: appCtrl.loadRmdJobList(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == .waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return Column(
                      spacing: 12,
                      children: (snapshot.data ?? [])
                          .map((e) => JobCard(model: e.toJobModel()))
                          .toList(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
