import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/models/com_model.dart';
import 'package:hire_up_poc_1/widgets/utils.dart';

class ComCard extends StatelessWidget {
  const ComCard({super.key, required this.model});

  final ComModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: .circular(18),
      ),
      padding: .all(8),
      child: Row(
        children: [
          Align(
            alignment: .topLeft,
            child: Image.network(model.companyLogo, width: .50, fit: .fitWidth),
          ),
          mid(),
        ],
      ),
    );
  }

  Widget mid() {
    final double sp = 4;
    return Column(
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

        Column(
          spacing: sp,
          children: [
            Text(
              '${model.location} · ${model.employmentType} · ${model.career} ↑',
              style: TextStyle().b14.cg,
            ),
            Text(model.salary, style: TextStyle().b14.cb),

            AppIcon.bookmark.icon(),
          ],
        ),
      ],
    );
  }
}
