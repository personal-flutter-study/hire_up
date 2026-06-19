import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hire_up_poc_1/main.dart';
import 'package:hire_up_poc_1/widgets/utils.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.h,
    this.p,
    this.s,
    this.controller,
    this.enable,
    this.color,
    this.hide,
    this.onChange,
    this.onSubmit,
    this.label,
    this.tip,
    this.alignment,
    this.length,
    this.formatter,
    this.padding,
  });

  final String h;
  final Widget? p;
  final Widget? s;
  final String? label;
  final String? tip;
  final EdgeInsets? padding;
  final bool? hide;
  final int? length;
  final FilteringTextInputFormatter? formatter;
  final TextAlign? alignment;
  final TextEditingController? controller;
  final bool? enable;
  final Color? color;
  final Function(String m)? onChange;
  final Function(String m)? onSubmit;

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
    return Column(
      spacing: 8,
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        if (widget.label != null)
          Text(widget.label!, style: TextStyle().b14.cg),
        Container(
          margin: .all(1),
          decoration: BoxDecoration(
            color: widget.color ?? Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 2),
            ],
          ),
          padding: widget.padding,
          child: TextField(
            inputFormatters: [?widget.formatter],
            maxLength: widget.length,
            textAlign: widget.alignment ?? TextAlign.start,
            onSubmitted: widget.onSubmit,
            onChanged: widget.onChange,
            enabled: widget.enable,
            controller: widget.controller,
            decoration: InputDecoration(
              counterText: '',
              contentPadding: .symmetric(vertical: 12),
              border: .none,
              hintText: widget.h,
              hintStyle: TextStyle().b14.cg,
              prefixIcon: widget.p != null
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: widget.p,
                    )
                  : null,
              suffixIcon: widget.s != null
                  ? Padding(padding: .all(12), child: widget.s)
                  : widget.hide != null
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            hide = !hide;
                          });
                        },
                        child: hide
                            ? AppIcon.visibility.icon(color: grey)
                            : AppIcon.visibilityOff.icon(color: grey),
                      ),
                    )
                  : null,
            ),
            obscureText: widget.s == null && widget.hide != null && hide,
            obscuringCharacter: '*',
          ),
        ),
        if (widget.tip != null) Text(widget.tip!, style: TextStyle().b14.cg),
      ],
    );
  }
}
