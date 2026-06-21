import 'package:flutter/material.dart';
import 'package:hire_up_poc_2/models/job_model.dart';
import 'package:hire_up_poc_2/screens/job_detail_screen.dart';
import 'package:hire_up_poc_2/utils.dart';
import 'package:hire_up_poc_2/widgets/bookmark_button.dart';

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
        child: 18.pa(
          child: Row(
            spacing: 18,
            crossAxisAlignment: .start,
            children: [
              Image.network(model.companyLogo, fit: .fitWidth, width: 50),
              Expanded(
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: .start,
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
                        '${model.location} · ${model.employmentType} · ${model.career}'
                            .text(.new().b14.cg),

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
