import 'package:flutter/material.dart';

class DateText extends StatelessWidget {
  final DateTime _dateTime;

  DateText(this._dateTime);

  @override
  Widget build(BuildContext context) {
    return Text("${_dateTime.day}/${_dateTime.month}/${_dateTime.year}");
  }
}