import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/models/recommend_job_model.dart';
import 'package:hire_up_poc_3/screens/job_detail_screen.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/bookmark_button.dart';

class JobCard2 extends StatelessWidget {
  const JobCard2({super.key, required this.model});

  final RecommendJobModel model;

  @override
  Widget build(BuildContext context) {
    final status = model.recruitStatus;

    return GestureDetector(
      onTap: () {
        context.push(JobDetailScreen(id: model.id));
      },
      child: SizedBox(
        height: 250,
        width: 200,
        child: Card(
          child: 12.pa(
            child: Column(
              mainAxisAlignment: .spaceAround,
              crossAxisAlignment: .start,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Card(
                      surfaceTintColor: status.color,
                      child: 8.pa(
                        child: status.lebel.text(
                          TextStyle(color: status.color),
                        ),
                      ),
                    ),
                    BookmarkButton(id: model.id),
                  ],
                ),

                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Image.network(model.companyLogo, fit: .fitWidth, width: 70),
                  ],
                ),

                model.jobTitle.text(.new().b18),
                '${model.location} · ${model.employmentType}'.text(
                  .new().b14.cg,
                ),
                model.salary.text(.new().b14.cb),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
