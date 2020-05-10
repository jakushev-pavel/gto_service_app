import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/components/widgets/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/widgets/navigation/tabs.dart';
import 'package:gtoserviceapp/components/widgets/shrunk_vertically.dart';
import 'package:gtoserviceapp/models/calculator.dart';
import 'package:gtoserviceapp/models/gender.dart';
import 'package:gtoserviceapp/screens/calculator_result/calculator_result.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Калькулятор"),
          automaticallyImplyLeading: false,
        ),
        body: _buildBody(context),
        bottomNavigationBar: NavigationBar(Tabs.Calculator),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ShrunkVertically(
      child: CardPadding(
        child: Column(
          children: <Widget>[
            _buildGenderRow(context),
            _buildAgeRow(context),
            SizedBox(height: 12),
            _buildSubmitButton(context),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }

  Row _buildAgeRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Text("Возраст:"),
        SizedBox(width: 8),
        _buildAgeInput(context),
      ],
    );
  }

  Row _buildGenderRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Text("Пол:"),
        SizedBox(width: 44),
        _buildGenderSelector(context),
      ],
    );
  }

  Widget _buildGenderSelector(BuildContext context) {
    var calc = Provider.of<CalculatorModel>(context);
    return DropdownButton(
      value: calc.gender != null ? calc.gender : null,
      items: _buildGenderSelectorItems(),
      onChanged: (value) => _onGenderSelectorUpdated(context, value),
      hint: Text("Пол"),
    );
  }

  List<DropdownMenuItem<Gender>> _buildGenderSelectorItems() {
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

  _onGenderSelectorUpdated(context, value) {
    var calc = Provider.of<CalculatorModel>(context, listen: false);
    calc.gender = value;
  }

  Widget _buildAgeInput(BuildContext context) {
    var calc = Provider.of<CalculatorModel>(context);
    return SizedBox(
      width: 32,
      child: TextFormField(
        textAlign: TextAlign.center,
        initialValue: calc.age?.toString(),
        keyboardType: TextInputType.number,
        onChanged: (text) => _onAgeChanged(context, text),
      ),
    );
  }

  _onAgeChanged(context, text) {
    var calc = Provider.of<CalculatorModel>(context, listen: false);
    calc.age = int.tryParse(text);
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text("Получить результаты"),
        onPressed: _onSubmitButtonPressed(context),
        disabledColor: Colors.grey.shade400,
        disabledTextColor: Colors.black,
      ),
    );
  }

  _onSubmitButtonPressed(context) {
    var calc = Provider.of<CalculatorModel>(context);
    if (calc.age == null || calc.gender == null) {
      return null;
    }

    return () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => CalculatorResultScreen(),
        ));
  }
}
