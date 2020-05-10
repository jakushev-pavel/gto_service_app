import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/models/gender.dart';
import 'package:gtoserviceapp/models/trials.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/routes.dart';

class SecondaryResultResponse {
  int secondaryResult;

  SecondaryResultResponse({this.secondaryResult});

  SecondaryResultResponse.fromJson(Map<String, dynamic> json) {
    secondaryResult = json['secondResult'];
  }
}

class CalculatorRepo {
  static CalculatorRepo get I {
    return GetIt.I<CalculatorRepo>();
  }

  Future<TrialsModel> fetchTrials(int age, Gender gender) async {
    var json = await API.I.get(Routes.Trial.withArgs(age: age, gender: gender));
    return TrialsModel.fromJson(json);
  }

  Future<SecondaryResultResponse> fetchSecondaryResult(
    int trialId,
    int primaryResult,
  ) async {
    var json = await API.I.get(Routes.TrialSecondaryResult.withArgs(
      trialId: trialId,
      primaryResult: primaryResult,
    ));
    return SecondaryResultResponse.fromJson(json);
  }
}
