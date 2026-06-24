import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/utils.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    this.controller,
    this.hide,
    this.s,
    this.p,
    required this.h,
    this.enable = true,
    this.change,
    this.submit,
    this.label,
  });

  final TextEditingController? controller;
  final String? label;
  final String h;
  final Widget? s;
  final Widget? p;
  final Function(String value)? change;
  final Function(String value)? submit;
  final bool? hide;
  final bool enable;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool hide = false;

  @override
  Widget build(BuildContext context) {
    final style = InputDecoration(
      contentPadding: .symmetric(vertical: 16),
      border: .none,
      hintText: widget.h,
      prefixIcon: widget.p,
      suffixIcon: widget.s,
    );

    return Column(
      crossAxisAlignment: .start,
      children: [
        if (widget.label != null) widget.label!.text(.new().b14.cg),
        Container(
          padding: .symmetric(horizontal: 12),
          margin: .all(1),
          decoration: BoxDecoration(
            borderRadius: .circular(12),
            color: Colors.white,
            border: .all(color: grey.withAlpha(100), width: 2),
          ),
          child: TextField(
            onSubmitted: widget.submit,
            onChanged: widget.change,
            enabled: widget.enable,
            obscuringCharacter: '.',
            obscureText: hide,
            decoration: widget.hide != null
                ? style.copyWith(
                    suffixIcon: IconButton(
                      style: IconButton.styleFrom(
                        minimumSize: .zero,
                        tapTargetSize: .shrinkWrap,
                        padding: .zero,
                      ),
                      onPressed: () {
                        setState(() {
                          hide = !hide;
                        });
                      },
                      icon: Icon(
                        hide ? Icons.visibility : Icons.visibility_off,
                        color: grey,
                      ),
                    ),
                  )
                : style,
            controller: widget.controller,
          ),
        ),
      ],
    );
  }
}
