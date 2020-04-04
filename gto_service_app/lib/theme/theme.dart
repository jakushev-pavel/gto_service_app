import 'package:flutter/material.dart';

ThemeData buildTheme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    buttonColor: Colors.blue.shade200,
    textTheme: TextTheme(
      body1: TextStyle(
        fontSize: 16,
      )
    ),
  );
}
