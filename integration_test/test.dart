import 'package:flutter/material.dart';

import 'package:hire_up_poc_3/main.dart' as app;

import 'package:flutter_test/flutter_test.dart';
import 'package:hire_up_poc_3/screens/edit_resume_screen.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  int index = 0;

  Future<void> section(
    String action,
    Future Function() callback,
    WidgetTester tester,
  ) async {
    index++;
    debugPrint('[STEP No.$index] $action');
    await callback();
    await tester.pumpAndSettle();
    await Future.delayed(Duration(seconds: 5));
  }

  testWidgets('integration_test', (tester) async {
    await section('애플리케이션 실행', () async {
      SharedPreferences.setMockInitialValues({
        '_bookmarksKey': [],
        '_tagsKey': [],
      });

      app.main();
    }, tester);

    await section('하단 네비게이션의 "이력서" 탭 클릭', () async {
      await tester.tap(find.byKey(Key('하단 네비게이션의 "이력서" 탭 클릭')));
    }, tester);

    await section('"로그인" 버튼 클릭', () async {
      await tester.tap(find.byKey(Key('"로그인" 버튼 클릭')));
      await tester.pump(Duration(seconds: 3));
    }, tester);

    await section('정상 값으로 로그인 시도', () async {
      await tester.enterText(
        find.byKey(Key('이메일: test@example.com')),
        'test@example.com',
      );
      await tester.enterText(find.byKey(Key('비밀번호: Test1234!')), 'Test1234!');

      await tester.tap(find.byKey(Key('정상 값으로 로그인 시도')));

      await Future.delayed(Duration(seconds: 3));
    }, tester);

    await section('앱바 추가(+) 버튼 클릭', () async {
      await tester.tap(find.byKey(Key('앱바 추가(+) 버튼 클릭')));
    }, tester);

    await section('이름 입력 필드에 이름 입력', () async {
      await tester.enterText(find.byKey(Key('이름 입력 필드에 이름 입력')), '홍길동');
      await Future.delayed(Duration(seconds: 1));
    }, tester);

    await section('직무 드롭다운에서 직무 선택', () async {
      await tester.tap(find.byKey(Key('직무 드롭다운에서 직무 선택')));
      await Future.delayed(Duration(seconds: 1));
      await tester.tap(find.text('모바일 앱 개발자'));
    }, tester);

    await section('한 줄 소개 입력', () async {
      await tester.enterText(find.byKey(Key('한 줄 소개 입력')), '성장하는 개발자입니다');
    }, tester);

    await section('학력 영역 "추가" 버튼 클릭', () async {
      await tester.dragUntilVisible(
        find.byKey(Key('학력 영역 "추가" 버튼 클릭')),
        find.byKey(Key('학력 영역 "추가" 버튼 클릭 S')),
        .new(0, 100),
      );

      await tester.tap(find.byKey(Key('학력 영역 "추가" 버튼 클릭')));
    }, tester);

    await section('학교명 입력 후 "저장" 버튼 클릭', () async {
      await tester.enterText(find.byKey(Key('학교명: 한국대학교')), '한국대학교');
      await tester.enterText(find.byKey(Key('전공: 컴퓨터공학과')), '컴퓨터공학과');
      await tester.tap(find.byKey(Key('학교명 입력 후 "저장" 버튼 클릭')));
    }, tester);

    await section('"경력" 탭 클릭', () async {
      await tester.tap(find.byKey(Key('"경력" 탭 클릭')));
    }, tester);

    await section('"경력 추가" 버튼 클릭', () async {
      await tester.tap(find.byKey(Key('"경력 추가" 버튼 클릭')));
      await Future.delayed(Duration(seconds: 1));
    }, tester);

    await section('회사명, 직책 입력 후 "저장" 버튼 클릭', () async {
      await tester.enterText(find.byKey(Key('회사명: 테크스타트업')), '테크스타트업');
      await tester.enterText(find.byKey(Key('직책: 모바일 앱 개발자')), '모바일 앱 개발자');
      await tester.tap(find.byKey(Key('회사명, 직책 입력 후 "저장" 버튼 클릭')));
    }, tester);

    await section('"프로젝트" 탭 클릭', () async {
      await tester.tap(find.byKey(Key('"프로젝트" 탭 클릭')));
    }, tester);

    await section('"프로젝트 추가" 버튼 클릭', () async {
      await tester.tap(find.byKey(Key('"프로젝트 추가" 버튼 클릭')));
      await Future.delayed(Duration(seconds: 1));
    }, tester);

    await section('프로젝트명, 사용 기술 입력 후 "저장" 버튼 클릭', () async {
      await tester.enterText(
        find.byKey(Key('프로젝트명: HireUp 채용 플랫폼')),
        'HireUp 채용 플랫폼',
      );
      await tester.enterText(
        find.byKey(Key('사용 기술: Flutter, Dart')),
        'Flutter, Dart',
      );
      await tester.tap(find.byKey(Key('프로젝트명, 사용 기술 입력 후 "저장" 버튼 클릭')));
    }, tester);

    await section('"기술 스택" 탭 클릭', () async {
      await tester.tap(find.byKey(Key('"기술 스택" 탭 클릭')));
    }, tester);

    await section('기술 입력 후 추가 버튼 클릭', () async {
      await tester.enterText(find.byKey(Key('기술: Flutter')), 'Flutter');
      await tester.tap(find.byKey(Key('기술 입력 후 추가 버튼 클릭')));
    }, tester);

    await section('동일한 기술 재입력 후 추가 버튼 클릭', () async {
      await tester.enterText(find.byKey(Key('기술: Flutter')), 'Flutter');
      await tester.tap(find.byKey(Key('기술 입력 후 추가 버튼 클릭')));
    }, tester);

    await section('"저장하기" 버튼 클릭', () async {
      await tester.tap(find.byKey(Key('"저장하기" 버튼 클릭')));
      await Future.delayed(Duration(seconds: 3));
    }, tester);

    await section('생성된 이력서 카드 위치까지 스크롤', () async {
      await Future.delayed(Duration(seconds: 3));

      await tester.dragUntilVisible(
        find.byKey(Key('생성된 이력서 카드 위치까지 스크롤 $saveId')),
        find.byKey(Key('생성된 이력서 카드 위치까지 스크롤 S')),
        .new(0, 10),
      );
    }, tester);
  });
}
