import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtoserviceapp/models/calculator.dart';
import 'package:provider/provider.dart';

class AgeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(hintText: "Возраст"),
      keyboardType: TextInputType.number,
      onSubmitted: (text) => _onChanged(context, text),
      onChanged: (text) => _onChanged(context, text),
    );
  }

  _onChanged(context, text) {
    var calc = Provider.of<CalculatorModel>(context, listen: false);
    calc.age = int.tryParse(text);
  }
}
