import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtoserviceapp/models/calculator.dart';
import 'package:gtoserviceapp/models/trials.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:provider/provider.dart';

class CalculatorResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var calc = Provider.of<CalculatorModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text("Калькулятор")),
      body: _buildBody(calc.age, calc.gender),
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
              title: _buildTrial(group.trials[index]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTrial(TrialModel trial) {
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
}
