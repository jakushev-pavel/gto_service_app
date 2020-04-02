import 'package:flutter/material.dart';
import 'package:gtoserviceapp/models/trials.dart';
import 'package:gtoserviceapp/services/api/api.dart';

class Trial extends StatefulWidget {
  final TrialModel _trial;

  Trial(this._trial);

  @override
  State<StatefulWidget> createState() => _TrialState(_trial);
}

class _TrialState extends State<Trial> {
  final TrialModel _trial;
  int _primaryResult;

  _TrialState(this._trial);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(_trial.trialName),
        Row(
          children: <Widget>[
            _buildTrialResult(_trial.resultForGold, Colors.yellow),
            _buildTrialResult(_trial.resultForSilver, Colors.grey),
            _buildTrialResult(_trial.resultForBronze, Colors.brown.shade300),
          ],
        ),
        Wrap(
          children: <Widget>[
            _buildPrimaryResult(),
            _buildSecondaryResult(),
          ],
        )
      ],
    );
  }

  Widget _buildTrialResult(String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(Icons.brightness_1, color: color),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildPrimaryResult() {
    return SizedBox(
      height: 32,
      width: 128,
      child: TextFormField(
        onChanged: _onPrimaryResultChanged,
        keyboardType: TextInputType.number,
      ),
    );
  }

  _onPrimaryResultChanged(String value) {
    setState(() {
      _primaryResult = int.tryParse(value);
    });
  }

  Widget _buildSecondaryResult() {
    if (_primaryResult == null) {
      return Text("...");
    }

    return FutureBuilder(
        future: API.I.fetchSecondaryResult(_trial.trialId, _primaryResult),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.secondaryResult.toString());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return CircularProgressIndicator();
        });
  }
}
