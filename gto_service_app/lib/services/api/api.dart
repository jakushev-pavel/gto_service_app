import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/components/helpers/try_catch_log.dart';
import 'package:gtoserviceapp/models/gender.dart';
import 'package:gtoserviceapp/models/trials.dart';
import 'package:gtoserviceapp/services/api/api_error.dart';
import 'package:gtoserviceapp/services/api/models.dart';
import 'package:gtoserviceapp/services/api/routes.dart';
import 'package:gtoserviceapp/services/auth/auth.dart';
import 'package:http/http.dart';

import 'headers.dart';

class API {
  final baseURL = Uri.parse("http://petrodim.beget.tech/api/v1");
  final Client _httpClient = Client();

  static API get I {
    return GetIt.I<API>();
  }

  Future<dynamic> get(
    String path, {
    auth = false,
  }) async {
    return tryCatchLog(() async {
      print("GET $path");
      final response = await _sendRequest(false, () => _get(path, auth));
      return _jsonDecode(response);
    });
  }

  Future<dynamic> _get(String path, bool auth) {
    final url = Uri.parse("$baseURL$path");
    var headers = buildHeaders(
      auth: auth,
    );

    return _httpClient.get(url, headers: headers);
  }

  Future<dynamic> post(
    String path, {
    dynamic args,
    bool auth = false,
    bool refresh = false,
  }) async {
    return tryCatchLog(() async {
      print("POST $path");
      Response response =
          await _sendRequest(auth, () => _post(path, args, auth, refresh));
      return _jsonDecode(response);
    });
  }

  Future<Response> _post(
    String path,
    dynamic args,
    bool auth,
    bool refresh,
  ) async {
    final url = Uri.parse("$baseURL$path");
    var headers = buildHeaders(
      content: args != null,
      auth: auth,
      refresh: refresh,
    );

    return _httpClient.post(url, body: jsonEncode(args), headers: headers);
  }

  Future delete(String path) async {
    return tryCatchLog(() async {
      print("DELETE $path");
      await _sendRequest(true, _withRefresh(() => _delete(path)));
      return;
    });
  }

  Future<Response> _delete(String path) {
    final url = Uri.parse("$baseURL$path");
    var headers = buildHeaders(
      auth: true,
    );

    return _httpClient.delete(url, headers: headers);
  }

  Future put(
    String path,
    args, {
    bool auth,
  }) async {
    return tryCatchLog(() async {
      print("PUT $path");
      await _sendRequest(true, _withRefresh(() => _put(path, args)));
      return;
    });
  }

  Future<Response> _put(String path, dynamic args) async {
    final url = Uri.parse("$baseURL$path");
    var headers = buildHeaders(
      content: true,
      auth: true,
    );

    return _httpClient.put(url, body: jsonEncode(args), headers: headers);
  }

  Future<Response> _sendRequest(
      bool refresh, Future<Response> Function() request) {
    return _withErrorHandling(
        _withOrWithoutRefresh(refresh, () => request()))();
  }

  Future<Response> Function() _withOrWithoutRefresh(
      bool refresh, Future<Response> Function() request) {
    if (refresh) {
      return _withRefresh(request);
    } else {
      return request;
    }
  }

  Future<Response> Function() _withRefresh(
      Future<Response> Function() request) {
    return () async {
      var response = await request();

      if (response.statusCode != 200) {
        await Auth.I.refresh();
        return request();
      }

      return response;
    };
  }

  Future<Response> Function() _withErrorHandling(
      Future<Response> Function() request) {
    return () async {
      var response = await request();

      if (response.statusCode != 200) {
        throw APIErrors.fromResponse(response);
      }

      return response;
    };
  }

  _jsonDecode(Response response) {
    if (response.body.isEmpty) {
      return null;
    }

    return jsonDecode(response.body);
  }

  Future<GetUserInfoResponse> getUserInfo() async {
    var json = await post(
      Routes.Info.toStr(),
      auth: true,
    );
    return GetUserInfoResponse.fromJson(json);
  }

  Future<TrialsModel> fetchTrials(int age, Gender gender) async {
    var json = await get(Routes.Trial.withArgs(age: age, gender: gender));
    return TrialsModel.fromJson(json);
  }

  Future<SecondaryResultResponse> fetchSecondaryResult(
    int trialId,
    int primaryResult,
  ) async {
    var json = await get(Routes.TrialSecondaryResult.withArgs(
      trialId: trialId,
      primaryResult: primaryResult,
    ));
    return SecondaryResultResponse.fromJson(json);
  }
}
