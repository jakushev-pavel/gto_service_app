import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtoserviceapp/models/trials.dart';
import 'package:gtoserviceapp/screens/calculator_result/trial.dart';

class Trials extends StatelessWidget {
  final TrialsModel _trials;

  Trials(this._trials);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
