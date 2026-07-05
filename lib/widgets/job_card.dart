import 'package:flutter/material.dart';
import 'package:hire_up_poc_5/app_ctrl.dart';
import 'package:hire_up_poc_5/models/job_model.dart';
import 'package:hire_up_poc_5/utils.dart';
import 'package:hire_up_poc_5/screens/job_detail_screen.dart';
import 'package:hire_up_poc_5/widgets/login_bottom.dart';

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
        child: 12.pa(
          child: Row(
            spacing: 12,
            crossAxisAlignment: .start,
            children: [
              Image.network(model.companyLogo, fit: .fitWidth, width: 60),

              Expanded(
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: .start,
                  children: [
                    model.companyName.text(TextStyle(fontSize: 16)),
                    model.jobTitle.text(TextStyle().b18),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        "${model.location} · ${model.employmentType} · ${model.career} ↑"
                            .text(TextStyle().cg.b14),

                        ListenableBuilder(
                          listenable: appCtrl.ticker,
                          builder: (context, child) {
                            final ac = appCtrl.bookmarks.contains(model.id);
                            return IconButton(
                              onPressed: () {
                                if (appCtrl.token.isEmpty) {
                                  LoginBottom().show(context);
                                } else {
                                  appCtrl.bookmark(model.id);
                                }
                              },
                              style: IconButton.styleFrom(
                                tapTargetSize: .shrinkWrap,
                                padding: .zero,
                                minimumSize: .zero,
                              ),
                              icon: Icon(
                                ac ? Icons.bookmark : Icons.bookmark_outline,
                                color: ac ? blue : grey,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    model.salary.text(TextStyle().b14.cb),
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
