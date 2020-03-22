import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/models/calculator.dart';
import 'package:gtoserviceapp/models/trials.dart';
import 'package:gtoserviceapp/screens/calculator_result/trials.dart';
import 'package:gtoserviceapp/services/api/api.dart';

class Result extends StatelessWidget {
  final Future<TrialsModel> trials;

  Result(int age, Gender gender)
      : trials = GetIt.I<API>().fetchTrials(age, gender);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: trials,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Trials(snapshot.data);
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
