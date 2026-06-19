import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/controllers/app_ctrl.dart';
import 'package:hire_up_poc_1/main.dart';
import 'package:hire_up_poc_1/screeens/job_book_screen.dart';
import 'package:hire_up_poc_1/screeens/search_screen.dart';
import 'package:hire_up_poc_1/widgets/base_scaffold.dart';
import 'package:hire_up_poc_1/widgets/job_card.dart';
import 'package:hire_up_poc_1/widgets/search_field.dart';

import '../widgets/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ValueListenableBuilder(
          valueListenable: appCtrl.user,
          builder: (context, value, child) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    AppImg.app_icon.image(size: 100),
                    GestureDetector(
                      onTap: () {
                        context.go(JobBookScreen());
                      },
                      child: Icons.bookmark_border_outlined.icon(size: 30),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: .symmetric(vertical: 18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('안녕하세요, ', style: TextStyle().b14),
                        Text(
                          '${value?.name ?? '게스트'}님!',
                          style: TextStyle().b14.cb,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('새로운 기회', style: TextStyle().b18.cb),
                        Text('를 찾아보세요.', style: TextStyle().b18),
                      ],
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  context.go(SearchScreen());
                },
                child: SearchField(
                  enable: false,
                  h: '직무, 회사, 키워드 검색',
                  p: Icons.search.icon(color: Colors.grey),
                ),
              ),

              Expanded(child: _Body()),
            ],
          ),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  Sort sort = .latest;
  CateGory category = .who;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: .symmetric(vertical: 18), child: tags()),
        line(),

        24.sh,

        Expanded(
          child: FutureBuilder(
            future: appCtrl.loadJobList(context, sort: sort, cate: category),
            builder: (context, snapshot) {
              if (snapshot.connectionState == .waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Column(
                  spacing: 18,
                  children: (snapshot.data ?? [])
                      .map((e) => JobCard(model: e))
                      .toList(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget tags() => SingleChildScrollView(
    scrollDirection: .horizontal,
    child: Row(
      children: CateGory.values
          .map(
            (e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: e == category ? Colors.white : grey,
                  backgroundColor: e == category ? blue : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    category = e;
                  });
                },
                child: Text(e.label, style: TextStyle().b14),
              ),
            ),
          )
          .toList(),
    ),
  );

  Widget line() => Row(
    mainAxisAlignment: .spaceBetween,
    children: [
      Text('전체 공고', style: TextStyle().b18),
      PopupMenuButton(
        onSelected: (value) {
          setState(() {
            sort = value;
          });
        },
        itemBuilder: (context) => Sort.values
            .map(
              (e) => PopupMenuItem(
                value: e,
                child: Text(e.label, style: TextStyle().b16),
              ),
            )
            .toList(),
        child: Row(
          children: [
            Text(sort.label, style: TextStyle().b14.cg),
            Icon(Icons.keyboard_arrow_down_outlined, color: grey),
          ],
        ),
      ),
    ],
  );
}
