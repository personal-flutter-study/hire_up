import 'package:flutter/cupertino.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';

final ValueNotifier<int> _ticker = ValueNotifier(0);

class ResumeCareer extends StatefulWidget {
  const ResumeCareer({super.key});

  @override
  State<ResumeCareer> createState() => _ResumeCareerState();
}

class _ResumeCareerState extends State<ResumeCareer> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: ValueListenableBuilder(
        valueListenable: _ticker,
        builder: (context, value, child) {
          return Column(children: []);
        },
      ),
    );
  }
}
