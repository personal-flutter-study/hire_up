import 'package:flutter/material.dart';
import 'package:hire_up_poc_2/utils.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.h,
    this.controller,
    this.p,
    this.s,
    this.padding,
    this.enable,
    this.hide,
  });

  final String h;
  final bool? enable;
  final TextEditingController? controller;
  final Widget? p;
  final EdgeInsets? padding;
  final Widget? s;
  final bool? hide;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late bool hide;

  @override
  void initState() {
    hide = widget.hide ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: .all(color: grey.withAlpha(100)),
        borderRadius: .circular(12),
        color: Colors.white,
      ),
      padding: widget.padding ?? .symmetric(horizontal: 12),
      child: TextField(
        enabled: widget.enable,
        decoration: InputDecoration(
          contentPadding: .symmetric(vertical: 12),
          border: .none,
          suffixIcon:
              widget.s ??
              (widget.hide != null
                  ? IconButton(
                      style: ButtonStyle().min,
                      onPressed: () {
                        setState(() {
                          hide = !hide;
                        });
                      },
                      icon: Icon(
                        hide
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: grey,
                      ),
                    )
                  : null),
          prefixIcon: widget.p,
          hint: widget.h.text(.new().b14.cg),
        ),
        controller: widget.controller,
        obscuringCharacter: '*',
        obscureText: hide!,
      ),
    );
  }
}
