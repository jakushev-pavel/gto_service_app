import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/models/calculator.dart';
import 'package:gtoserviceapp/models/trials.dart';
import 'package:gtoserviceapp/services/api/api_error.dart';
import 'package:gtoserviceapp/services/api/models.dart';
import 'package:gtoserviceapp/services/api/routes.dart';
import 'package:gtoserviceapp/services/auth/auth.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';
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
    print(path);
    final url = Uri.parse("$baseURL$path");
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      return _processResponseError(response, url);
    }

    return jsonDecode(response.body);
  }

  Future<dynamic> _post(
    String path, {
    dynamic args,
    Future<Map<String, String>> Function() headers,
    bool refresh = true,
  }) async {
    final url = Uri.parse("$baseURL$path");
    args ??= <String, dynamic>{};
    final response =
        await _httpClient.post(url, body: jsonEncode(args), headers: await headers());

    if (response.statusCode != 200) {
      if (refresh) {
        await Auth.I.refresh();
        return _post(path, args: args, headers: headers, refresh: false);
      }
      return _processResponseError(response, url);
    }

    return jsonDecode(response.body);
  }

  Future<Map<String, String>> _buildPostHeaders() async {
    return {
      "Content-Type": "application/json;charset=UTF-8",
    };
  }

  Future<Map<String, String>> _buildPostAuthHeaders() async {
    return {
      ...await _buildPostHeaders(),
      "Authorization": await Storage.I.read(Keys.accessToken),
    };
  }

  Future<LoginResponse> login(String email, String password) async {
    return _post(
      Routes.Login.toStr(),
      args: LoginArgs(email: email, password: password).toJson(),
      headers: _buildPostHeaders,
    ).then((json) => LoginResponse.fromJson(json));
  }

  Future<Map<String, String>> _buildPostRefreshHeaders() async {
    return {
      ...await _buildPostHeaders(),
      "Authorization": await Storage.I.read(Keys.refreshToken),
    };
  }

  Future<RefreshResponse> refresh() async {
    return _post(
      Routes.Refresh.toStr(),
      headers: _buildPostRefreshHeaders,
      refresh: false,
    ).then((json) => RefreshResponse.fromJson(json));
  }

  Future<GetUserInfoResponse> getUserInfo() async {
    return _post(
      Routes.Info.toStr(),
      headers: _buildPostAuthHeaders,
    ).then((json) => GetUserInfoResponse.fromJson(json));
  }

  Future<TrialsModel> fetchTrials(int age, Gender gender) {
    return _get(Routes.Trial.withArgs(age: age, gender: gender))
        .then((json) => TrialsModel.fromJson(json));
  }

  Future<SecondaryResultResponse> fetchSecondaryResult(int trialId, int primaryResult) {
    return _get(Routes.TrialSecondaryResult.withArgs(
      trialId: trialId,
      primaryResult: primaryResult,
    )).then((json) => SecondaryResultResponse.fromJson(json));
  }
}
