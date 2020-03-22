import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtoserviceapp/models/calculator.dart';
import 'package:gtoserviceapp/screens/calculator_result/result.dart';
import 'package:provider/provider.dart';

class CalculatorResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var calc = Provider.of<CalculatorModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text("Калькулятор")),
      body: Result(calc.age, calc.gender),
    );
  }
}
