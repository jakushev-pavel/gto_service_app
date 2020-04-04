import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/text_placeholder/text_placeholder.dart';
import 'package:gtoserviceapp/models/calculator.dart';
import 'package:gtoserviceapp/models/gender.dart';
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
    return ListView(
      children: <Widget>[
        _buildHeader(gender, age, trials),
        Divider(color: Colors.black),
        _buildTrialsList(trials),
      ],
    );
  }

  Widget _buildHeader(Gender gender, int age, TrialsModel trials) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Пол: ${gender.toStr()}"),
            SizedBox(height: 2),
            Text("Возраст: $age"),
            SizedBox(height: 2),
            Text("Возрастная ступень: ${trials.ageCategory}"),
          ],
        ),
      ),
    );
  }

  Widget _buildTrialsList(TrialsModel trials) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index >= trials.groups.length) {
          return null;
        }
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: _buildGroup(trials.groups[index]),
        );
      },
      separatorBuilder: (_, __) => Divider(color: Colors.black),
      itemCount: trials.groups.length,
    );
  }

  Widget _buildGroup(GroupModel group) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index >= group.trials.length) {
          return null;
        }
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: _buildTrial(context, group.trials[index]),
        );
      },
    );
  }

  Widget _buildTrial(BuildContext context, TrialModel trial) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(trial.trialName),
            SizedBox.fromSize(size: Size.fromHeight(4)),
            _buildTrialResults(trial),
            SizedBox.fromSize(size: Size.fromHeight(4)),
            _buildPrimarySecondaryResults(trial, context),
          ],
        ),
      ),
    );
  }

  Widget _buildTrialResults(TrialModel trial) {
    return Row(
      children: <Widget>[
        _buildTrialResult(trial.resultForGold, Colors.yellow),
        _buildTrialResult(trial.resultForSilver, Colors.grey),
        _buildTrialResult(trial.resultForBronze, Colors.brown.shade300),
      ],
    );
  }

  Widget _buildTrialResult(String value, Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: Row(
        children: <Widget>[
          Icon(Icons.brightness_1, color: color),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildPrimarySecondaryResults(TrialModel trial, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Text("Баллы: "),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Первичный: "),
                _buildPrimaryResult(trial.trialId),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            _buildSecondaryResult(context, trial.trialId),
          ]..removeWhere((x) => x == null),
        ),
      ],
    );
  }

  Widget _buildPrimaryResult(trialId) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 32,
          height: 48,
          child: TextFormField(
            textAlign: TextAlign.center,
            initialValue: _primaryResults[trialId]?.toString(),
            onChanged: (value) => _onPrimaryResultChanged(trialId, value),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  _onPrimaryResultChanged(int trialId, String value) {
    setState(() {
      _primaryResults[trialId] = int.tryParse(value);
    });
  }

  Widget _buildSecondaryResult(BuildContext context, int trialId) {
    if (_primaryResults[trialId] == null) {
      return null;
    }

    var future = API.I.fetchSecondaryResult(trialId, _primaryResults[trialId]);
    ErrorDialog.showOnFutureError(context, future);

    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: <Widget>[
                Text("Вторичный: "),
                Text(
                  snapshot.data.secondaryResult.toString(),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            );
          }

          return TextPlaceholder.progress();
        });
  }
}
