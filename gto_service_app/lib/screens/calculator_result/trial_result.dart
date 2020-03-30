import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrialResult extends StatelessWidget {
  final String _value;
  final Color _color;

  TrialResult(this._value, this._color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(Icons.brightness_1, color: _color),
          ),
          Text(_value),
        ],
      ),
    );
  }
}
