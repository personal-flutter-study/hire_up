import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_up_poc_4/app_ctrl.dart';
import 'package:hire_up_poc_4/utils.dart';
import 'package:hire_up_poc_4/widgets/login_bottom_sheet.dart';

Widget bookmarkButton(int id) {
  return ValueListenableBuilder(
    valueListenable: appCtrl.bookmarks,
    builder: (context, value, child) {
      final active = value.contains(id);

      return IconButton(
        style: IconButton.styleFrom(
          tapTargetSize: .shrinkWrap,
          minimumSize: .zero,
          padding: .zero,
        ),
        onPressed: () {
          if (appCtrl.user.value == null) {
            LoginBottomSheet().show(context);
          } else {
            appCtrl.bookmark(id);
          }
        },
        icon: Icon(
          active ? Icons.bookmark : Icons.bookmark_outline,
          color: active ? blue : grey,
        ),
      );
    },
  );
}
