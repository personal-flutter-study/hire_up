


part of 'edit_resume_screen.dart';


class _Info extends StatelessWidget {
  const _Info({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            color: Colors.white,
            child: 18.pa(
              child: Column(
                spacing: 12,
                crossAxisAlignment: .start,
                children: [
                  '프로필'.text(TextStyle().b24),

                  Row(
                    spacing: 12,
                    crossAxisAlignment: .start,
                    children: [
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () async {
                              final temp = await ImagePicker().pickImage(
                                source: .camera,
                              );

                              if (temp == null) return;

                              _image = File(temp.path);
                              appCtrl.ticker.value++;
                            },
                            child: "카메라로 촬영".text(TextStyle()),
                          ),
                          PopupMenuItem(
                            onTap: () async {
                              final temp = await ImagePicker().pickImage(
                                source: .gallery,
                              );

                              if (temp == null) return;

                              _image = File(temp.path);
                              appCtrl.ticker.value++;
                            },
                            child: "갤러리에서 선택".text(TextStyle()),
                          ),
                          PopupMenuItem(
                            onTap: () {},
                            child: "프로필 사진 삭제".text(TextStyle()),
                          ),
                        ],
                        child: CircleAvatar(
                          backgroundImage: FileImage(_image ?? File('')),
                          radius: 38,
                        ),
                      ),

                      Expanded(
                        child: Column(
                          spacing: 12,
                          children: [
                            Column(
                              spacing: 4,
                              crossAxisAlignment: .start,
                              children: [
                                '이름'.text(TextStyle().b18.cg),

                                1.pa(
                                  child: TextField(
                                    controller: _na,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: .lerp(grey, Colors.white, .8),
                                      contentPadding: .symmetric(
                                        horizontal: 24,
                                        vertical: 16,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: .circular(12),
                                        borderSide: BorderSide(
                                          color: grey,
                                          width: 1.5,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: .circular(12),
                                        borderSide: BorderSide(
                                          color: grey,
                                          width: 1.5,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: .circular(12),
                                        borderSide: BorderSide(
                                          color: grey,
                                          width: 1.5,
                                        ),
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
                                '직무'.text(TextStyle().b18.cg),
                                PopupMenuButton(
                                  onSelected: (value) {
                                    _role = value;
                                    print(_role);
                                    appCtrl.ticker.value++;
                                  },
                                  itemBuilder: (context) => JobRole.values
                                      .map(
                                        (e) => PopupMenuItem(
                                      value: e,
                                      child: e.l.text(),
                                    ),
                                  )
                                      .toList(),
                                  child: 1.pa(
                                    child: TextField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        suffixIcon: Icons.keyboard_arrow_down
                                            .icon(size: 32),
                                        prefixIcon: Align(
                                          alignment: .centerLeft,
                                          child: _role?.l.text(),
                                        ),
                                        filled: true,
                                        fillColor: .lerp(
                                          grey,
                                          Colors.white,
                                          .8,
                                        ),
                                        contentPadding: .symmetric(
                                          horizontal: 24,
                                          vertical: 16,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: .circular(12),
                                          borderSide: BorderSide(
                                            color: grey,
                                            width: 1.5,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: .circular(12),
                                          borderSide: BorderSide(
                                            color: grey,
                                            width: 1.5,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: .circular(12),
                                          borderSide: BorderSide(
                                            color: grey,
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Column(
                    spacing: 4,
                    crossAxisAlignment: .center,
                    children: [
                      '한 줄 소개'.text(TextStyle().b18.cg),

                      1.pa(
                        child: TextField(
                          maxLength: 50,
                          controller: _oneLineIntro,
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
                ],
              ),
            ),
          ),

          Card(
            color: Colors.white,
            child: 18.pa(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  '개인 정보'.text(TextStyle().b24),
                  GridView(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 100,
                      crossAxisSpacing: 12,
                    ),
                    children: [
                      Column(
                        spacing: 4,
                        crossAxisAlignment: .start,
                        children: [
                          '이메일'.text(TextStyle().b18.cg),

                          1.pa(
                            child: TextField(
                              controller: _em,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: .lerp(grey, Colors.white, .8),
                                contentPadding: .symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: .circular(12),
                                  borderSide: BorderSide(
                                    color: grey,
                                    width: 1.5,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: .circular(12),
                                  borderSide: BorderSide(
                                    color: grey,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: .circular(12),
                                  borderSide: BorderSide(
                                    color: grey,
                                    width: 1.5,
                                  ),
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
                          '연락처'.text(TextStyle().b18.cg),

                          1.pa(
                            child: TextField(
                              controller: _ph,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: .lerp(grey, Colors.white, .8),
                                contentPadding: .symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: .circular(12),
                                  borderSide: BorderSide(
                                    color: grey,
                                    width: 1.5,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: .circular(12),
                                  borderSide: BorderSide(
                                    color: grey,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: .circular(12),
                                  borderSide: BorderSide(
                                    color: grey,
                                    width: 1.5,
                                  ),
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
                          '생년월일'.text(TextStyle().b18.cg),

                          1.pa(
                            child: TextField(
                              controller: _bir,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: .lerp(grey, Colors.white, .8),
                                contentPadding: .symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: .circular(12),
                                  borderSide: BorderSide(
                                    color: grey,
                                    width: 1.5,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: .circular(12),
                                  borderSide: BorderSide(
                                    color: grey,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: .circular(12),
                                  borderSide: BorderSide(
                                    color: grey,
                                    width: 1.5,
                                  ),
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
                          '위치'.text(TextStyle().b18.cg),

                          1.pa(
                            child: TextField(
                              controller: _loc,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: .lerp(grey, Colors.white, .8),
                                contentPadding: .symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: .circular(12),
                                  borderSide: BorderSide(
                                    color: grey,
                                    width: 1.5,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: .circular(12),
                                  borderSide: BorderSide(
                                    color: grey,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: .circular(12),
                                  borderSide: BorderSide(
                                    color: grey,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Column(
                    spacing: 4,
                    crossAxisAlignment: .start,
                    children: [
                      '링크'.text(TextStyle().b18.cg),

                      1.pa(
                        child: TextField(
                          controller: _lin,
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
                ],
              ),
            ),
          ),

          Card(
            color: Colors.white,
            child: 18.pa(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  '소개'.text(TextStyle().b24),
                  1.pa(
                    child: TextField(
                      controller: _na,
                      maxLines: 5,
                      maxLength: 300,
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
          ),

          Card(
            color: Colors.white,
            child: 18.pa(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    children: [
                      '학력'.text(TextStyle().b24),

                      Spacer(),

                      TextButton(
                        onPressed: () {
                          _EduBottom().show(context);
                        },
                        child: Row(
                          children: [
                            Icons.add.icon(color: blue),
                            '추가'.text(TextStyle().b16.cb),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: _educations
                        .map(
                          (e) => Card(
                        color: Colors.white,
                        child: 18.pa(
                          child: Row(
                            crossAxisAlignment: .start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    '${e.schoolName} • ${e.major}'.text(),
                                  ],
                                ),
                              ),

                              Icons.delete.iButton(() {
                                _educations.remove(e);
                                appCtrl.ticker.value++;
                              }, color: Colors.red),
                            ],
                          ),
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EduBottom extends StatefulWidget {
  const _EduBottom({super.key});

  show(context) => showModalBottomSheet(
    context: context,
    builder: (context) => this,
    enableDrag: true,
    showDragHandle: true,
    backgroundColor: Colors.white,
    isScrollControlled: true,
  );

  @override
  State<_EduBottom> createState() => _EduBottomState();
}

class _EduBottomState extends State<_EduBottom> {
  final TextEditingController na = TextEditingController();
  final TextEditingController fi = TextEditingController();
  final TextEditingController gr = TextEditingController();
  final TextEditingController en = TextEditingController();
  final TextEditingController ou = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return 18.pa(
      child: Column(
        spacing: 12,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          '학력 추가'.text(TextStyle().b24),

          Column(
            spacing: 4,
            crossAxisAlignment: .start,
            children: [
              '학교명'.text(TextStyle().b18.cg),

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
              '전공'.text(TextStyle().b18.cg),

              1.pa(
                child: TextField(
                  controller: fi,
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
              '학위'.text(TextStyle().b18.cg),

              1.pa(
                child: TextField(
                  controller: gr,
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
                    '입학'.text(TextStyle().b18.cg),

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
                    '졸업'.text(TextStyle().b18.cg),

                    1.pa(
                      child: TextField(
                        controller: ou,
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
                if (na.text.isEmpty || fi.text.isEmpty) {
                  '필수 입력 값을 채워주세요'.toast();
                  return;
                }

                _educations.add(Edu(schoolName: na.text, major: fi.text));

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
