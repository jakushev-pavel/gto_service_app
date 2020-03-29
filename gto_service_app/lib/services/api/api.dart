import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/models/calculator.dart';
import 'package:gtoserviceapp/models/trials.dart';
import 'package:gtoserviceapp/services/api/api_error.dart';
import 'package:gtoserviceapp/services/api/models.dart';
import 'package:http/http.dart';

class API {
  final baseURL = Uri.parse("http://petrodim.beget.tech/api/v1");
  final Client _httpClient = Client();

  static API get I {
    return GetIt.I<API>();
  }

  Future _processResponseError(Response response, Uri url) {
    try {
      var json = jsonDecode(response.body);
      return Future.error(APIErrors.fromJson(json));
    } on FormatException catch (_) {
      return Future.error("GET $url request failed");
    }
  }

  Future<dynamic> _get<Out>(String path) async {
    final url = Uri.parse("$baseURL$path");
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      return _processResponseError(response, url);
    }

    return jsonDecode(response.body);
  }

  Future<dynamic> _post(
    String path,
    dynamic args, {
    Map<String, String> headers,
  }) async {
    final url = Uri.parse("$baseURL$path");
    headers ??= <String, String>{};
    headers["Content-Type"] = "application/json;charset=UTF-8";
    final response =
        await _httpClient.post(url, body: jsonEncode(args), headers: headers);

    if (response.statusCode != 200) {
      return _processResponseError(response, url);
    }

    return jsonDecode(response.body);
  }

  Future<LoginResponse> login(String email, String password) async {
    return _post(
      "/auth/login",
      LoginArgs(email: email, password: password).toJson(),
    ).then((json) => LoginResponse.fromJson(json));
  }

  Future<TrialsModel> fetchTrials(int age, Gender gender) {
    return _get("/trial/$age/${gender.toInt()}")
        .then((json) => TrialsModel.fromJSON(json));
  }
}
