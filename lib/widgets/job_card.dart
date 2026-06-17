import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/controllers/app_ctrl.dart';
import 'package:hire_up_poc_1/models/job_model.dart';
import 'package:hire_up_poc_1/screeens/job_detail_screen.dart';
import 'package:hire_up_poc_1/widgets/login_bottom_sheet.dart';
import 'package:hire_up_poc_1/widgets/utils.dart';

class JobCard extends StatelessWidget {
  const JobCard({super.key, required this.model});

  final JobModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(JobDetailScreen());
      },
      child: Container(
        width: .maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: .circular(18),
        ),
        padding: .all(12),
        child: Row(
          crossAxisAlignment: .start,
          children: [
            Align(
              alignment: .topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  model.companyLogo,
                  width: 50,
                  fit: .fitWidth,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(child: mid()),
          ],
        ),
      ),
    );
  }

  Widget mid() {
    final double sp = 4;
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          spacing: sp,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(model.companyName, style: TextStyle().b14.cg),
                Text(model.deadlineLabel, style: TextStyle().b14.cb),
              ],
            ),
            Text(model.jobTitle, style: TextStyle().b16),

            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${model.location} · ${model.employmentType} · ${model.career}',
                    style: TextStyle().b14.cg,
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    tapTargetSize: .shrinkWrap,
                    minimumSize: .zero,
                    padding: .zero,
                  ),
                  onPressed: () {

                    if(appCtrl.user == null) {

                      LoginBottomSheet().show(context);

                    }

                  },
                  icon: AppIcon.bookmark.icon(),
                ),
              ],
            ),
            Text(model.salary, style: TextStyle().b14.cb),
          ],
        );
      }
    );
  }
}
