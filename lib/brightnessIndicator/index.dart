import 'package:flutter/material.dart';

import 'bar.dart';
import 'indicator.dart';

class BrightnessIndicator extends StatefulWidget {
  final double initialValue;
  final Function(double) onChange;

  BrightnessIndicator({
    this.initialValue,
    this.onChange,
  });

  @override
  _BrightnessIndicatorState createState() => _BrightnessIndicatorState();
}

class _BrightnessIndicatorState extends State<BrightnessIndicator> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _progress = widget.initialValue ?? 0.0;
  }

  onChange(double p) {
    setState(() {
      _progress = p;
    });

    if (widget.onChange != null) {
      widget.onChange(_progress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Bar(
            initialValue: widget.initialValue,
            onChange: onChange,
          ),
          Container(
            height: 40.0,
          ),
          Indicator(
            progress: _progress,
          ),
        ],
      ),
    );
  }
}
