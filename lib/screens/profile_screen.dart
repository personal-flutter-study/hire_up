import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/app_ctrl.dart';
import 'package:hire_up_poc_3/main.dart';
import 'package:hire_up_poc_3/models/user_detail_model.dart';
import 'package:hire_up_poc_3/screens/interview_history_screen.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/login_bottom_sheet.dart';
import '../widgets/p_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: '프로필'.text(.new().b24)),
      child: ValueListenableBuilder(
        valueListenable: appCtrl.token,
        builder: (context, value, child) {
          if (value == null) {
            return Center(
              child: Column(
                spacing: 8,
                mainAxisAlignment: .center,
                children: [
                  Icons.person_outline.icon(size: 88, color: grey),
                  '로그인이 필요합니다'.text(.new().b18),
                  '로그인 후 프로필을 확인할 수 있어요'.text(.new().b16.cg),
                  12.sh,
                  100.pw(
                    child: PButton(
                      child: ['로그인'.text(.new().b16.cw)],
                      tap: () {
                        LoginBottomSheet().show(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return FutureBuilder(
            future: _load(context),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == .waiting)
                return Center(child: CircularProgressIndicator());

              final data = asyncSnapshot.data;

              if (data == null) {
                return Center(child: '정보를 불러올 수 없습니다'.text(.new().b24));
              }

              return 18.pa(
                child: Column(
                  spacing: 12,
                  children: [
                    Column(
                      children: [
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              onTap: () async {
                                final image = await ImagePicker().pickImage(
                                  source: .camera,
                                );

                                if (image != null) {
                                  appCtrl.saveProfile(image.path);
                                  setState(() {});
                                }
                              },
                              child: '카메라로 촬영'.text(),
                            ),
                            PopupMenuItem(
                              onTap: () async {
                                final image = await ImagePicker().pickImage(
                                  source: .gallery,
                                );

                                if (image != null) {
                                  appCtrl.saveProfile(image.path);
                                  setState(() {});
                                }
                              },
                              child: '갤러리에서 선택'.text(),
                            ),
                            if (appCtrl.profilePath != null)
                              PopupMenuItem(
                                onTap: () {
                                  prefs.remove(AppCtrl.profileKey);
                                  setState(() {});
                                },
                                child: '프로필 사진 삭제'.text(),
                              ),
                          ],
                          child: CircleAvatar(
                            radius: 38,
                            backgroundColor: Colors.white,
                            backgroundImage: FileImage(
                              .new(
                                appCtrl.profilePath != null
                                    ? appCtrl.profilePath!
                                    : 'assets/images/default_profile.png',
                              ),
                            ),
                          ),
                        ),

                        12.sh,

                        Row(
                          spacing: 12,
                          mainAxisAlignment: .center,
                          children: [
                            data.name.text(.new().b18),
                            Card(
                              surfaceTintColor: blue,
                              child: '회원님'.text(.new().b14.cb),
                            ),
                          ],
                        ),
                        data.email.text(.new().b14.cg),
                        data.intro.text(.new().b16.cg),
                      ],
                    ),

                    Card(
                      color: Colors.white,
                      child: 18.pa(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Icons.bookmark_outline.icon(
                                    color: blue,
                                    size: 38,
                                  ),
                                  data.bookmarkCount.toString().text(
                                    .new().b20,
                                  ),
                                  '관심 공고'.text(.new().b14.cg),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Icons.mic_outlined.icon(
                                    color: blue,
                                    size: 38,
                                  ),
                                  data.interviewCount.toString().text(
                                    .new().b20,
                                  ),
                                  '면접'.text(.new().b14.cg),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Icons.description_outlined.icon(
                                    color: blue,
                                    size: 38,
                                  ),
                                  data.resumeCount.toString().text(.new().b20),
                                  '이력서'.text(.new().b14.cg),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          GestureDetector(
                            behavior: .opaque,
                            onTap: () {
                              appCtrl.page.value = 2;
                            },
                            child: 18.pa(
                              child: Row(
                                spacing: 12,
                                children: [
                                  Icons.description_outlined.icon(color: grey),
                                  '이력서 관리'.text(.new().b14.cg),
                                  Spacer(),
                                  Icons.arrow_forward_ios.icon(color: grey),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: .infinity,
                            child: Divider(indent: 58, height: 0),
                          ),
                          GestureDetector(
                            behavior: .opaque,
                            onTap: () {
                              context.push(InterviewHistoryScreen());
                            },
                            child: 18.pa(
                              child: Row(
                                spacing: 12,
                                children: [
                                  Icons.mic_outlined.icon(color: grey),
                                  'AI 면접 기록'.text(.new().b14.cg),
                                  Spacer(),
                                  Icons.arrow_forward_ios.icon(color: grey),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: .infinity,
                            child: Divider(indent: 58, height: 0),
                          ),
                          GestureDetector(
                            behavior: .opaque,
                            onTap: () {
                              launchUrl(Uri.parse('http://support.hireup.com'));
                            },
                            child: 18.pa(
                              child: Row(
                                spacing: 12,
                                children: [
                                  Icons.headphones.icon(color: grey),
                                  '고객센터'.text(.new().b14.cg),
                                  Spacer(),
                                  Icons.arrow_forward_ios.icon(color: grey),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: .infinity,
                            child: Divider(indent: 58, height: 0),
                          ),
                          GestureDetector(
                            behavior: .opaque,
                            onTap: () {
                              '앱 정보 서비스는 준비중에 있습니다.'.snack(context);
                            },
                            child: 18.pa(
                              child: Row(
                                spacing: 12,
                                children: [
                                  Icons.info_outline.icon(color: grey),
                                  '앱 정보'.text(.new().b14.cg),
                                  Spacer(),
                                  Icons.arrow_forward_ios.icon(color: grey),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: '로그아웃 하시겠습니까?'.text(),
                            actions: [
                              CupertinoButton(
                                child: '취소'.text(),
                                onPressed: () {
                                  context.pop();
                                },
                              ),
                              CupertinoButton(
                                child: '로그아웃'.text(),
                                onPressed: () {
                                  appCtrl.token.value = null;
                                  '로그아웃 되었습니다.'.snack(context);
                                  context.pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: '로그아웃'.text(.new().b16.cb),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Future<UserDetailModel?> _load(BuildContext context) async {
  try {
    final res = await get(
      Uri.parse('$baseUri/profile'),
      headers: {'Authorization': 'Bearer ${appCtrl.token.value ?? ''}'},
    );

    final body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return UserDetailModel.fromJson(body['data']);
    } else {
      for (var e in (body['errors'] as List)) {
        (e['message'] as String).snack(context);
      }
    }
  } catch (e) {
    print(e);
  }
  return null;
}
