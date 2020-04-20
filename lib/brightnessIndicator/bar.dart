import 'package:flutter/material.dart';

class Bar extends StatefulWidget {
  final Function(double) onChange;
  final double initialValue;

  Bar({
    this.onChange,
    this.initialValue = 0.0,
  });

  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _progress = widget.initialValue ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (event) {
        var verticalPosition = event.localPosition.dy;
        var maxHeight = context.size.height;
        var newProgress = verticalPosition / maxHeight;
        newProgress = 1 - newProgress;
        newProgress = newProgress.clamp(0, 1);
        setState(() {
          _progress = newProgress;
        });

        if (widget.onChange != null) {
          widget.onChange(_progress);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CustomPaint(
          painter: Painter(progress: _progress),
          child: Container(
            width: 50,
            height: 200,
          ),
        ),
      ),
    );
  }
}

class Painter extends CustomPainter {
  double progress;

  Painter({
    this.progress = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white.withOpacity(0.5);
    Rect rect = Rect.fromLTRB(
      0.0,
      0.0,
      size.width,
      size.height,
    );
    canvas.drawRect(rect, paint);

    var paintProgress = Paint();
    paintProgress.color = Colors.white;
    Rect rectProgress = Rect.fromLTRB(
      0.0,
      size.height * (1 - progress),
      size.width,
      size.height,
    );
    canvas.drawRect(rectProgress, paintProgress);
  }

  @override
  bool shouldRepaint(Painter oldDelegate) {
    if (oldDelegate.progress != progress) return true;
    return false;
  }
}
