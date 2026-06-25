import 'package:flutter/material.dart';
import 'package:hire_up_poc_4/models/job_model.dart';
import 'package:hire_up_poc_4/screens/job_detail_screen.dart';
import 'package:hire_up_poc_4/utils.dart';
import 'package:hire_up_poc_4/widgets.dart';

class JobCard extends StatelessWidget {
  const JobCard({super.key, required this.model, this.tap});

  final JobModel model;
  final VoidCallback? tap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          tap ??
          () {
            context.go(JobDetailScreen());
          },
      child: Card(
        color: Colors.white,
        child: SizedBox(
          height: 150,
          child: 18.pa(
            child: Row(
              spacing: 18,
              crossAxisAlignment: .start,
              children: [
                Image.network(model.companyLogo, fit: .fitWidth, width: 60),

                Expanded(
                  child: Column(
                    mainAxisAlignment: .spaceAround,
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          model.companyName.text(style: .new().b14.cg),
                          model.deadlineLabel.text(style: .new().b14.cg),
                        ],
                      ),
                      model.jobTitle.text(style: .new().b16),
                      Row(
                        children: [
                          Expanded(
                            child:
                                '${model.location} · ${model.employmentType} · ${model.career}'
                                    .text(style: .new().b14.cg),
                          ),

                          bookmarkButton(model.id),
                        ],
                      ),
                      model.salary.text(style: .new().b14.cb),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
