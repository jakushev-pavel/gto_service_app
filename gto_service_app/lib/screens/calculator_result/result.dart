import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/models/calculator.dart';
import 'package:gtoserviceapp/models/trials.dart';
import 'package:gtoserviceapp/screens/calculator_result/trials.dart';
import 'package:gtoserviceapp/services/api/api.dart';

class Result extends StatelessWidget {
  final Future<TrialsModel> _trials;
  final int _age;
  final Gender _gender;

  Result(this._age, this._gender)
      : _trials = API.I.fetchTrials(_age, _gender);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _trials,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Trials(snapshot.data, _age, _gender);
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
