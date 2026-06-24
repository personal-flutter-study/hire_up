import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hire_up_poc_3/models/job_model.dart';
import 'package:hire_up_poc_3/screens/job_detail_screen.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/bookmark_button.dart';

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
            context.push(JobDetailScreen(id: model.id));
          },
      child: Card(
        color: Colors.white,
        child: 18.pa(
          child: Row(
            spacing: 18,
            crossAxisAlignment: .start,
            children: [
              Image.network(model.companyLogo, fit: .fitWidth, width: 60),

              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 8,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        model.companyName.text(.new().b14.cg),
                        model.deadlineLabel.text(.new().b14.cg),
                      ],
                    ),
                    model.jobTitle.text(.new().b16),

                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Expanded(
                          child:
                              '${model.location} · ${model.employmentType} · ${model.career}'
                                  .text(.new().b14.cg),
                        ),
                        BookmarkButton(id: model.id),
                      ],
                    ),
                    model.salary.text(.new().b14.cb),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
