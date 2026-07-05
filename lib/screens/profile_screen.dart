import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_up_poc_5/app_ctrl.dart';
import 'package:hire_up_poc_5/models/profile_model.dart';
import 'package:hire_up_poc_5/screens/interview_his_screen.dart';
import 'package:hire_up_poc_5/utils.dart';
import 'package:hire_up_poc_5/widgets/base_scaffold.dart';
import 'package:hire_up_poc_5/widgets/login_bottom.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: '프로필'.text(TextStyle().b24)),
      child: ListenableBuilder(
        listenable: appCtrl.ticker,
        builder: (context, child) {
          if (appCtrl.token.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: .center,
                spacing: 12,
                children: [
                  Icons.person_outline.icon(size: 78, color: grey),

                  SizedBox(height: 12),

                  '로그인이 필요합니다.'.text(TextStyle().b24),
                  '로그인 후 프로필을 확인할 수 있어요'.text(TextStyle().b18.cg),

                  SizedBox(height: 12),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: .symmetric(vertical: 16),
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: .circular(12),
                      ),
                    ),
                    onPressed: () {
                      LoginBottom().show(context);
                    },
                    child: 88.pw(child: '로그인'.text(TextStyle().b16.cw)),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: FutureBuilder(
              future: _load(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == .waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final data = snapshot.data;

                if (data == null) return Center(child: '조회할 수 없습니다.'.text());

                return SingleChildScrollView(
                  child: 18.pa(
                    child: Column(
                      spacing: 12,
                      children: [
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              onTap: () async {
                                final temp = await ImagePicker().pickImage(
                                  source: .camera,
                                );
                  
                                if (temp == null) return;
                  
                                setState(() {
                                  image = File(temp.path);
                                });
                              },
                              child: "카메라로 촬영".text(TextStyle()),
                            ),
                            PopupMenuItem(
                              onTap: () async {
                                final temp = await ImagePicker().pickImage(
                                  source: .gallery,
                                );
                  
                                if (temp == null) return;
                  
                                setState(() {
                                  image = File(temp.path);
                                });
                              },
                              child: "갤러리에서 선택".text(TextStyle()),
                            ),
                            PopupMenuItem(
                              onTap: () {},
                              child: "프로필 사진 삭제".text(TextStyle()),
                            ),
                          ],
                          child: CircleAvatar(
                            backgroundImage: FileImage(image ?? File('')),
                            radius: 38,
                          ),
                        ),
                  
                        Row(
                          mainAxisAlignment: .center,
                          children: [
                            data.name.text(TextStyle().b20),
                            Card(
                              surfaceTintColor: blue,
                              child: '회원님'.text(TextStyle().b16.cb),
                            ),
                          ],
                        ),
                  
                        data.email.text(TextStyle()),
                        data.intro.text(TextStyle().b16.cg),
                  
                        Card(
                          color: Colors.white,
                          child: 18.pa(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    spacing: 8,
                                    children: [
                                      Icons.bookmark_outline.icon(
                                        color: blue,
                                        size: 38,
                                      ),
                                      data.bookmarkCount.toString().text(
                                        TextStyle().b24,
                                      ),
                                      '관심 공고'.toString().text(TextStyle().cg),
                                    ],
                                  ),
                                ),
                  
                                SizedBox(height: 48, child: VerticalDivider()),
                  
                                Expanded(
                                  child: Column(
                                    spacing: 8,
                                    children: [
                                      Icons.mic.icon(color: blue, size: 38),
                                      data.interviewCount.toString().text(
                                        TextStyle().b24,
                                      ),
                                      '면접'.toString().text(TextStyle().cg),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 48, child: VerticalDivider()),
                  
                                Expanded(
                                  child: Column(
                                    spacing: 8,
                                    children: [
                                      Icons.description_outlined.icon(
                                        color: blue,
                                        size: 38,
                                      ),
                                      data.resumeCount.toString().text(
                                        TextStyle().b24,
                                      ),
                                      '이력서'.toString().text(TextStyle().cg),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  
                        Card(
                          color: Colors.white,
                          child: 8.pa(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    appCtrl.page.value = 2;
                                  },
                                  child: 12.pa(
                                    child: Row(
                                      spacing: 12,
                                      children: [
                                        Icons.description_outlined.icon(
                                          size: 32,
                                          color: grey,
                                        ),
                  
                                        '이력서 관리'.text(TextStyle().b18),
                  
                                        Spacer(),
                  
                                        Icons.arrow_forward_ios.icon(color: grey),
                                      ],
                                    ),
                                  ),
                                ),
                  
                                SizedBox(
                                  width: .infinity,
                                  child: Divider(indent: 48),
                                ),
                  
                                GestureDetector(
                                  onTap: () {
                                    context.go(InterviewHisScreen());
                                  },
                                  child: 12.pa(
                                    child: Row(
                                      spacing: 12,
                                      children: [
                                        Icons.mic_outlined.icon(
                                          size: 32,
                                          color: grey,
                                        ),
                  
                                        'AI 면접 기록'.text(TextStyle().b18),
                  
                                        Spacer(),
                  
                                        Icons.arrow_forward_ios.icon(color: grey),
                                      ],
                                    ),
                                  ),
                                ),
                  
                                SizedBox(
                                  width: .infinity,
                                  child: Divider(indent: 48),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    launchUrl(
                                      Uri.parse('http://support.hireup.com'),
                                    );
                                  },
                                  child: 12.pa(
                                    child: Row(
                                      spacing: 12,
                                      children: [
                                        Icons.headphones.icon(
                                          size: 32,
                                          color: grey,
                                        ),
                  
                                        '고객센터'.text(TextStyle().b18),
                  
                                        Spacer(),
                  
                                        Icons.arrow_forward_ios.icon(color: grey),
                                      ],
                                    ),
                                  ),
                                ),
                  
                                SizedBox(
                                  width: .infinity,
                                  child: Divider(indent: 48),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    '준비중'.toast();
                                  },
                                  child: 12.pa(
                                    child: Row(
                                      spacing: 12,
                                      children: [
                                        Icons.info_outline.icon(
                                          size: 32,
                                          color: grey,
                                        ),
                  
                                        '앱 정보'.text(TextStyle().b18),
                  
                                        Spacer(),
                  
                                        Icons.arrow_forward_ios.icon(color: grey),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        '로그아웃'.tButton(() {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: '로그아웃 하시겠습니까?'.text(),
                              actions: [
                                CupertinoButton(
                                  onPressed: () {
                                    setState(() {
                                      appCtrl.token = '';
                                    });
                                    context.back();
                                  },
                                  child: '로그아웃'.text(),
                                ),
                              ],
                            ),
                          );
                        }, tStyle: TextStyle().b18.cb),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

Future<ProfileModel?> _load() async {
  try {
    final res = await get(Uri.parse('$baseUrl/profile'), headers: authHeader);

    final body = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return ProfileModel.fronJson(body['data']);
    }
  } catch (e) {
    print(e);
  }

  return null;
}
