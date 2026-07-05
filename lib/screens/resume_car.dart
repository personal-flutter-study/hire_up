


part of 'edit_resume_screen.dart';


class _Car extends StatelessWidget {
  const _Car({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: _careers
              .map(
                (e) => Card(
              color: Colors.white,
              child: 18.pa(
                child: Row(
                  crossAxisAlignment: .start,
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 4,
                        crossAxisAlignment: .start,
                        children: [
                          '${e.companyName} • ${e.position}'.text(
                            TextStyle().b16,
                          ),
                          '${e.startDate} • ${e.endDate}'.text(),
                          '${e.description}'.text(),
                        ],
                      ),
                    ),

                    Icons.delete.iButton(() {
                      _careers.remove(e);
                      appCtrl.ticker.value++;
                    }, color: Colors.red),
                  ],
                ),
              ),
            ),
          )
              .toList(),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: .symmetric(vertical: 16),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: .circular(12),
              side: BorderSide(color: blue),
            ),
          ),
          onPressed: () {
            _CarBottom().show(context);
          },
          child: Row(
            mainAxisAlignment: .center,
            children: [
              Icons.add.icon(color: blue),
              '경력 추가'.text(TextStyle().b16.cb),
            ],
          ),
        ),
      ],
    );
  }
}

class _CarBottom extends StatefulWidget {
  const _CarBottom({super.key});

  show(context) => showModalBottomSheet(
    context: context,
    builder: (context) => this,
    enableDrag: true,
    showDragHandle: true,
    backgroundColor: Colors.white,
    isScrollControlled: true,
  );

  @override
  State<_CarBottom> createState() => _CarBottomState();
}

class _CarBottomState extends State<_CarBottom> {
  final TextEditingController na = TextEditingController();
  final TextEditingController po = TextEditingController();
  final TextEditingController en = TextEditingController();
  final TextEditingController ou = TextEditingController();
  final TextEditingController wo = TextEditingController();

  bool check = false;

  @override
  Widget build(BuildContext context) {
    return 18.pa(
      child: Column(
        spacing: 12,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          '경력 추가'.text(TextStyle().b24),

          Column(
            spacing: 4,
            crossAxisAlignment: .start,
            children: [
              '회사명'.text(TextStyle().b18.cg),

              1.pa(
                child: TextField(
                  controller: na,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: .lerp(grey, Colors.white, .8),
                    contentPadding: .symmetric(horizontal: 24, vertical: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: .circular(12),
                      borderSide: BorderSide(color: grey, width: 1.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: .circular(12),
                      borderSide: BorderSide(color: grey, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: .circular(12),
                      borderSide: BorderSide(color: grey, width: 1.5),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Column(
            spacing: 4,
            crossAxisAlignment: .start,
            children: [
              '직책'.text(TextStyle().b18.cg),

              1.pa(
                child: TextField(
                  controller: po,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: .lerp(grey, Colors.white, .8),
                    contentPadding: .symmetric(horizontal: 24, vertical: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: .circular(12),
                      borderSide: BorderSide(color: grey, width: 1.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: .circular(12),
                      borderSide: BorderSide(color: grey, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: .circular(12),
                      borderSide: BorderSide(color: grey, width: 1.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: .start,
                  children: [
                    '입사'.text(TextStyle().b18.cg),

                    1.pa(
                      child: TextField(
                        controller: en,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: .lerp(grey, Colors.white, .8),
                          contentPadding: .symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: .circular(12),
                            borderSide: BorderSide(color: grey, width: 1.5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: .circular(12),
                            borderSide: BorderSide(color: grey, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: .circular(12),
                            borderSide: BorderSide(color: grey, width: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: .start,
                  children: [
                    '퇴사'.text(TextStyle().b18.cg),

                    1.pa(
                      child: TextField(
                        controller: ou,
                        decoration: InputDecoration(
                          enabled: !check,
                          filled: true,
                          fillColor: .lerp(grey, Colors.white, .8),
                          contentPadding: .symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: .circular(12),
                            borderSide: BorderSide(color: grey, width: 1.5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: .circular(12),
                            borderSide: BorderSide(color: grey, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: .circular(12),
                            borderSide: BorderSide(color: grey, width: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              Checkbox(
                value: check,
                onChanged: (value) {
                  setState(() {
                    check = !check;
                  });
                },
              ),

              '재직 중'.text(),
            ],
          ),

          Column(
            spacing: 4,
            crossAxisAlignment: .start,
            children: [
              '담당업무'.text(TextStyle().b18.cg),

              1.pa(
                child: TextField(
                  controller: wo,
                  maxLines: 3,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: .lerp(grey, Colors.white, .8),
                    contentPadding: .symmetric(horizontal: 24, vertical: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: .circular(12),
                      borderSide: BorderSide(color: grey, width: 1.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: .circular(12),
                      borderSide: BorderSide(color: grey, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: .circular(12),
                      borderSide: BorderSide(color: grey, width: 1.5),
                    ),
                  ),
                ),
              ),
            ],
          ),

          18.ph(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: .symmetric(vertical: 16),
                backgroundColor: blue,
                shape: RoundedRectangleBorder(borderRadius: .circular(12)),
              ),
              onPressed: () {
                if (na.text.isEmpty || po.text.isEmpty) {
                  '필수 입력 값을 채워주세요'.toast();
                  return;
                }

                _careers.add(
                  Car(
                    companyName: na.text,
                    position: po.text,
                    startDate: en.text,
                    endDate: en.text,
                    isCurrent: check,
                    description: wo.text,
                  ),
                );

                appCtrl.ticker.value++;
                context.back();
              },
              child: Row(
                mainAxisAlignment: .center,
                children: ['저장'.text(TextStyle().b16.cw)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}