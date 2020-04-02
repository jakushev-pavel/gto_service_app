import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/text_placeholder/text_placeholder.dart';
import 'package:gtoserviceapp/models/calculator.dart';
import 'package:gtoserviceapp/models/trials.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:provider/provider.dart';

class CalculatorResultScreen extends StatefulWidget {
  @override
  _CalculatorResultScreenState createState() => _CalculatorResultScreenState();
}

class _CalculatorResultScreenState extends State<CalculatorResultScreen> {
  Map<int, int> _primaryResults = {};

  @override
  Widget build(BuildContext context) {
    var calc = Provider.of<CalculatorModel>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text("Калькулятор")),
        body: _buildBody(calc.age, calc.gender),
      ),
    );
  }

  Widget _buildBody(int age, Gender gender) {
    return FutureBuilder(
      future: API.I.fetchTrials(age, gender),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildTrials(snapshot.data, age, gender);
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildTrials(TrialsModel trials, int age, Gender gender) {
    return Column(
      children: <Widget>[
        Text("Пол: ${gender.toStr()}"),
        Text("Возраст: $age"),
        Text(trials.ageCategory),
        Expanded(child: _buildList(trials)),
      ],
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }

  ListView _buildList(TrialsModel trials) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index >= trials.groups.length) {
          return null;
        }
        return ListTile(
          title: _buildGroup(trials.groups[index]),
        );
      },
    );
  }

  Widget _buildGroup(GroupModel group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Группа:"),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index >= group.trials.length) {
              return null;
            }
            return ListTile(
              title: _buildTrial(context, group.trials[index]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTrial(BuildContext context, TrialModel trial) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(trial.trialName),
        Row(
          children: <Widget>[
            _buildTrialResult(trial.resultForGold, Colors.yellow),
            _buildTrialResult(trial.resultForSilver, Colors.grey),
            _buildTrialResult(trial.resultForBronze, Colors.brown.shade300),
          ],
        ),
        Wrap(
          children: <Widget>[
            _buildPrimaryResult(trial.trialId),
            _buildSecondaryResult(context, trial.trialId),
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

  Widget _buildPrimaryResult(trialId) {
    return SizedBox(
      height: 32,
      width: 128,
      child: TextFormField(
        initialValue: _primaryResults[trialId]?.toString(),
        onChanged: (value) => _onPrimaryResultChanged(trialId, value),
        keyboardType: TextInputType.number,
      ),
    );
  }

  _onPrimaryResultChanged(int trialId, String value) {
    setState(() {
      _primaryResults[trialId] = int.tryParse(value);
    });
  }

  Widget _buildSecondaryResult(BuildContext context, int trialId) {
    if (_primaryResults[trialId] == null) {
      return TextPlaceholder.empty();
    }

    var future = API.I.fetchSecondaryResult(trialId, _primaryResults[trialId]);
    ErrorDialog.showOnFutureError(context, future);

    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.secondaryResult.toString());
          }

          return TextPlaceholder.progress();
        });
  }
}
