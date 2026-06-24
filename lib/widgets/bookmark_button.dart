import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/app_ctrl.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/login_bottom_sheet.dart';

class BookmarkButton extends StatelessWidget {
  const BookmarkButton({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appCtrl.bookmarks,
      builder: (context, value, child) {
        final active = value.contains(id);

        return IconButton(
          onPressed: () {
            if (appCtrl.user.value == null) {
              LoginBottomSheet().show(context);
            } else {
              appCtrl.bookmark(id);
            }
          },
          icon: Icon(
            size: 32,
            active ? Icons.bookmark : Icons.bookmark_border_outlined,
            color: active ? blue : grey,
          ),
        );
      },
    );
  }
}
