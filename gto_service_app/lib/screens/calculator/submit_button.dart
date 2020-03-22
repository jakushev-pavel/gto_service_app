import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtoserviceapp/screens/calculator_result/calculator_result.dart';

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("Получить результаты"),
      onPressed: () => _onPressed(context),
    );
  }

  _onPressed(context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => CalculatorResultScreen(),
    ));
  }
}