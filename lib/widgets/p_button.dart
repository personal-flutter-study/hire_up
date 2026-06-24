import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/utils.dart';

class PButton extends StatelessWidget {
  const PButton({super.key, required this.child, required this.tap});

  final List<Widget> child;
  final VoidCallback tap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: .circular(12)),
        padding: .symmetric(vertical: 16),
        backgroundColor: blue,
        alignment: .center,
      ),
      onPressed: tap,
      child: Row(mainAxisAlignment: .center, children: child),
    );
  }
}
