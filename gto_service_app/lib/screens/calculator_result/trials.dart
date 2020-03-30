import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtoserviceapp/models/calculator.dart';
import 'package:gtoserviceapp/models/trials.dart';
import 'package:gtoserviceapp/screens/calculator_result/trial.dart';

class Trials extends StatelessWidget {
  final TrialsModel _trials;
  final int _age;
  final Gender _gender;

  Trials(this._trials, this._age, this._gender);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Пол: ${_gender.toStr()}"),
        Text("Возраст: $_age"),
        Text(_trials.ageCategory),
        Expanded(child: _buildList()),
      ],
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }

  ListView _buildList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index >= _trials.length) {
          return null;
        }
        return ListTile(
          title: Trial(_trials.at(index)),
        );
      },
    );
  }
}
