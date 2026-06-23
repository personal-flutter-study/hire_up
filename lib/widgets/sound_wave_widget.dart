import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/main.dart';

class SoundWaveWidget extends StatelessWidget {
  const SoundWaveWidget({
    super.key,
    required this.volumes,
    required this.filled,
  });

  final List<double> volumes;
  final double filled;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: .fromHeight(50),
      painter: _SoundPaint(filled: filled, volumes: volumes),
    );
  }
}

class _SoundPaint extends CustomPainter {
  final List<double> volumes;
  final double filled;

  _SoundPaint({required this.volumes, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = .fill;

    for (var v in volumes.indexed) {
      final height = max(size.height * v.$2, size.height * .1);
      final width = size.width / volumes.length;

      final top = (size.height - height) / 2;
      final bottom = size.height - top;
      final left = v.$1 * width;
      final right = left + width;

      final color = v.$1 / volumes.length <= filled ? blue : grey;

      canvas.drawRRect(
        .fromRectAndRadius(
          .fromLTRB(left.toDouble() + 3, top, right.toDouble(), bottom),
          .circular(12),
        ),
        paint..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
