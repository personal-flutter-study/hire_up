import 'package:flutter/material.dart';
import 'package:hire_up_poc_2/app_ctrl.dart';
import 'package:hire_up_poc_2/utils.dart';
import 'package:hire_up_poc_2/widgets/login_bottom_sheet.dart';

class BookmarkButton extends StatelessWidget {
  const BookmarkButton({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final bookmark = appCtrl.bookmarkList.value.contains(id);
    return IconButton(
      style: IconButton.styleFrom().min,
      onPressed: () {
        if (appCtrl.user.value == null) {
          LoginBottomSheet().show(context);
          return;
        }
        appCtrl.bookmark(id);
      },
      icon: Icon(
        bookmark ? Icons.bookmark : Icons.bookmark_outline,
        color: bookmark ? blue : grey,
      ),
    );
  }
}
