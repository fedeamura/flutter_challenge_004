import 'package:challenge004/brightnessIndicator/index.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  static final Color _colorInitial = Colors.black;
  static final Color _colorFinal = Colors.blue;

  Color _backgroundColor = _colorInitial;

  _onChange(double progress) {
    setState(() {
      _backgroundColor = Color.lerp(_colorInitial, _colorFinal, progress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: BrightnessIndicator(
            onChange: _onChange,
          ),
        ),
      ),
    );
  }
}
