import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/controllers/app_ctrl.dart';
import 'package:hire_up_poc_1/main.dart';
import 'package:hire_up_poc_1/models/com_model.dart';
import 'package:hire_up_poc_1/screeens/search_screen.dart';
import 'package:hire_up_poc_1/widgets/base_scaffold.dart';
import 'package:hire_up_poc_1/widgets/com_card.dart';
import 'package:hire_up_poc_1/widgets/search_field.dart';
import 'package:http/http.dart';

import '../widgets/utils.dart';

enum CateGory {
  who('전체'),
  dev('개발'),
  des('디자인'),
  mct('마케팅');

  final String v;

  const CateGory(this.v);
}

enum Filter {
  latest('최신순'),
  popular('인기순'),
  salary('급여순');

  final String v;

  const Filter(this.v);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  AppImg.app_icon.image(size: 100),
                  GestureDetector(onTap: () {
                    
                  }, child: AppIcon.bookmark.icon(size: 30)),
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
                      Text('${appCtrl.name}님!', style: TextStyle().b14.cb),
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
                Navigator().go(context, SearchScreen());
              },
              child: SearchField(
                enable: false,
                h: '직무, 회사, 키워드 검색',
                p: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AppIcon.search.icon(color: Colors.grey),
                ),
              ),
            ),

            _Body(),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({super.key});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  Filter filter = .latest;
  CateGory cate = .who;

  final ValueNotifier<List<ComModel>> comList = ValueNotifier([]);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        final res = await get(Uri.parse('$baseUrl/jobs?sort=${filter.name}'));
        final data = jsonDecode(res.body);
        comList.value.addAll(
          (data['items'] as List).map((e) => ComModel.fromJson(e)),
        );
      } catch (e) {
        '조회 통신 오류'.snack(context);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: .symmetric(vertical: 18), child: tags()),

        top(),
        SingleChildScrollView(
          child: ValueListenableBuilder(
            valueListenable: comList,
            builder: (context, value, child) =>
                Column(children: value.map((e) => ComCard(model: e)).toList()),
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
                  foregroundColor: e == cate ? Colors.white : tGrey,
                  backgroundColor: e == cate ? blue : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    cate = e;
                  });
                },
                child: Text(e.v, style: TextStyle().b14),
              ),
            ),
          )
          .toList(),
    ),
  );

  Widget top() => Row(
    mainAxisAlignment: .spaceBetween,
    children: [
      Text('전체 공고', style: TextStyle().b18),
      PopupMenuButton(
        onSelected: (value) {
          setState(() {
            filter = value;
          });
        },
        itemBuilder: (context) => Filter.values
            .map(
              (e) => PopupMenuItem(
                value: e,
                child: Text(e.v, style: TextStyle().b16),
              ),
            )
            .toList(),
        child: Row(
          children: [
            Text(filter.v, style: TextStyle().b14.cg),
            Icon(Icons.keyboard_arrow_down_outlined, color: tGrey),
          ],
        ),
      ),
    ],
  );
}
