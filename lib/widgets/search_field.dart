import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/widgets/utils.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.h,
    this.p,
    this.s,
    this.controller,
    this.enable,
  });

  final String h;
  final Widget? p;
  final Widget? s;
  final TextEditingController? controller;
  final bool? enable;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 2),
        ],
      ),
      child: TextField(
        enabled: enable,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: .symmetric(vertical: 12),
          border: .none,
          hintText: h,
          hintStyle: TextStyle().b14.cg,
          prefixIcon: p,
          suffixIcon: s,
        ),
      ),
    );
  }
}
