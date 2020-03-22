import 'dart:convert';

import 'package:gtoserviceapp/models/calculator.dart';
import 'package:gtoserviceapp/models/trials.dart';
import 'package:gtoserviceapp/services/api/api_error.dart';
import 'package:http/http.dart';

class API {
  final baseURL = Uri.parse("http://petrodim.beget.tech/api/v1");
  final Client _httpClient = Client();

  Future<T> _get<T>(String path, T Function(dynamic) fromJSON) async {
    final url = Uri.parse("$baseURL$path");
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      try {
        var json = jsonDecode(response.body);
        return Future.error(APIError.fromJson(json));
      } catch (_) {
        return Future.error("GET $url request failed");
      }
    }

    var json = jsonDecode(response.body);
    return fromJSON(json);
  }

  Future<TrialsModel> fetchTrials(int age, Gender gender) {
    return _get(
      "/trial/$age/${genderToInt(gender)}",
      (json) => TrialsModel.fromJSON(json),
    );
  }

  int genderToInt(Gender gender) {
    switch (gender) {
      case Gender.Male:
        return 1;
        break;
      case Gender.Female:
        return 0;
        break;
      default:
        throw Exception("invalid gender");
    }
  }
}
