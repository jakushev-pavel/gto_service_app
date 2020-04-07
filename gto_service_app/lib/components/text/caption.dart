import 'package:flutter/material.dart';

class CaptionText extends StatelessWidget {
  final String _data;

  CaptionText(this._data);

  @override
  Widget build(BuildContext context) {
    return Text(
      _data,
      style: Theme.of(context).textTheme.caption,
    );
  }
}
