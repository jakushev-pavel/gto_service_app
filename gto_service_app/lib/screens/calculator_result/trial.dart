import 'package:flutter/material.dart';
import 'package:gtoserviceapp/models/trials.dart';
import 'package:gtoserviceapp/screens/calculator_result/trial_result.dart';

class Trial extends StatelessWidget {
  final TrialModel _trial;

  Trial(this._trial);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(_trial.trialName),
        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TrialResult(_trial.resultForGold, Colors.yellow),
            TrialResult(_trial.resultForSilver, Colors.grey),
            TrialResult(_trial.resultForBronze, Colors.brown.shade300),
          ],
        )
      ],
    );
  }
}
