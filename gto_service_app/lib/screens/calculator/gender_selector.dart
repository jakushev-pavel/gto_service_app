import 'package:flutter/material.dart';
import 'package:gtoserviceapp/models/calculator.dart';
import 'package:provider/provider.dart';

class GenderSelector extends StatefulWidget {
  @override
  State<GenderSelector> createState() {
    return GenderSelectorState();
  }
}

class GenderSelectorState extends State<GenderSelector> {
  @override
  Widget build(BuildContext context) {
    var calc = Provider.of<CalculatorModel>(context);
    return DropdownButton(
      value: calc.gender != null ? calc.gender : null,
      items: _buildItems(context),
      onChanged: (value) => _onChanged(context, value),
      hint: Text("Пол"),
    );
  }

  List<DropdownMenuItem<Gender>> _buildItems(context) {
    return <DropdownMenuItem<Gender>>[
      DropdownMenuItem(
        child: Text("Мужской"),
        value: Gender.Male,
      ),
      DropdownMenuItem(
        child: Text("Женский"),
        value: Gender.Female,
      ),
    ];
  }

  _onChanged(context, value) {
    var calc = Provider.of<CalculatorModel>(context, listen: false);
    calc.gender = value;
  }
}
