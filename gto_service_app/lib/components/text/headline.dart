import 'package:flutter/material.dart';

class HeadlineText extends StatelessWidget {
  final String _data;

  HeadlineText(this._data);

  @override
  Widget build(BuildContext context) {
    return Text(
      _data,
      style: Theme.of(context).textTheme.headline,
    );
  }
}
