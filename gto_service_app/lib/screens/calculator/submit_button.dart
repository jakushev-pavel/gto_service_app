import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtoserviceapp/models/calculator.dart';
import 'package:gtoserviceapp/screens/calculator_result/calculator_result.dart';
import 'package:provider/provider.dart';

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("Получить результаты"),
      onPressed: _onPressed(context),
      disabledColor: Colors.grey.shade400,
      disabledTextColor: Colors.black,
    );
  }

  _onPressed(context) {
    var calc = Provider.of<CalculatorModel>(context);
    if (calc.age == null || calc.gender == null) {
      return null;
    }

    return () => Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => CalculatorResultScreen(),
    ));
  }
}