import 'dart:math';

import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final double progress;

  Indicator({
    this.progress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Painter(progress: progress),
      child: Container(
        width: 50,
        height: 50,
      ),
    );
  }
}

class Painter extends CustomPainter {
  final double progress;

  Painter({
    this.progress = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), Paint());

    var paintCircle = Paint();
    paintCircle.color = Colors.white;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.5, paintCircle);

    var p = map(1 - progress, 0, 1, -0.5, 0.3);

    var paintCircle2 = Paint();
    paintCircle2.blendMode = BlendMode.clear;
    canvas.drawCircle(Offset(size.width * 0.75, size.height * p), size.width * 0.5, paintCircle2);

    canvas.restore();

    if (progress >= 0.7) {
      for (var angle = 0.0; angle < pi * 2; angle = angle + (pi * 2 / 8)) {
        var x1 = cos(angle) * size.width * 0.65 + size.width * 0.5;
        var y1 = sin(angle) * size.width * 0.65 + size.height * 0.5;

        var progressLine = progress - 0.7;
        progressLine = map(progressLine, 0, 0.3, 0, 1.0);

        var x2 = cos(angle) * size.width * (0.65 + progressLine * 0.3) + size.width * 0.5;
        var y2 = sin(angle) * size.width * (0.65 + progressLine * 0.3) + size.height * 0.5;

        var paintLine = Paint();
        paintLine.color = Colors.white;
        paintLine.style = PaintingStyle.stroke;
        paintLine.strokeWidth = 2;

        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paintLine);
      }
    }
  }

  @override
  bool shouldRepaint(Painter oldDelegate) {
    if (oldDelegate.progress != progress) return true;
    return false;
  }
}

double map(double x, double in_min, double in_max, double out_min, double out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}
