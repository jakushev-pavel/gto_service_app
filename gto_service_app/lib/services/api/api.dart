import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/models/gender.dart';
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

  _processResponseError(Response response, Uri url) {
    var json = jsonDecode(response.body);
    throw APIErrors.fromJson(json);
  }

  Future<dynamic> _get(String path) async {
    print(path);
    final url = Uri.parse("$baseURL$path");
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      _processResponseError(response, url);
    }

    return jsonDecode(response.body);
  }

  Future _delete(
    String path, {
    Map<String, String> Function() headers,
    bool refresh = true,
  }) async {
    print(path);
    final url = Uri.parse("$baseURL$path");
    final response = await _httpClient.delete(url, headers: headers());

    if (response.statusCode != 200) {
      if (refresh) {
        await Auth.I.refresh();
        return _delete(path, headers: headers, refresh: false);
      }
      _processResponseError(response, url);
    }

    return;
  }

  Future _put(
    String path, {
    dynamic args,
    Map<String, String> Function() headers,
    bool refresh = true,
  }) async {
    final url = Uri.parse("$baseURL$path");
    args ??= <String, dynamic>{};
    final response =
        await _httpClient.put(url, body: jsonEncode(args), headers: headers());

    if (response.statusCode != 200) {
      if (refresh) {
        await Auth.I.refresh();
        return _put(path, args: args, headers: headers, refresh: false);
      }
      return _processResponseError(response, url);
    }

    return;
  }

  Future<Map<String, dynamic>> _post(
    String path, {
    dynamic args,
    Map<String, String> Function() headers,
    bool refresh = true,
  }) async {
    final url = Uri.parse("$baseURL$path");
    args ??= <String, dynamic>{};
    final response =
        await _httpClient.post(url, body: jsonEncode(args), headers: headers());

    if (response.statusCode != 200) {
      if (refresh) {
        await Auth.I.refresh();
        return _post(path, args: args, headers: headers, refresh: false);
      }
      return _processResponseError(response, url);
    }

    return jsonDecode(response.body);
  }

  Map<String, String> _buildPostHeaders() {
    return {
      "Content-Type": "application/json;charset=UTF-8",
    };
  }

  Map<String, String> _buildAuthHeaders() {
    return {
      "Authorization": Storage.I.read(Keys.accessToken),
    };
  }

  Map<String, String> _buildPostAuthHeaders() {
    return {
      ..._buildPostHeaders(),
      ..._buildAuthHeaders(),
    };
  }

  Future<LoginResponse> login(String email, String password) async {
    return _post(
      Routes.Login.toStr(),
      args: LoginArgs(email: email, password: password).toJson(),
      headers: _buildPostHeaders,
    ).then((json) => LoginResponse.fromJson(json));
  }

  Map<String, String> _buildPostRefreshHeaders() {
    return {
      ..._buildPostHeaders(),
      "Authorization": Storage.I.read(Keys.refreshToken),
    };
  }

  Future<RefreshResponse> refresh() async {
    var json = await _post(
      Routes.Refresh.toStr(),
      headers: _buildPostRefreshHeaders,
      refresh: false,
    );
    return RefreshResponse.fromJson(json);
  }

  Future<GetUserInfoResponse> getUserInfo() async {
    var json = await _post(
      Routes.Info.toStr(),
      headers: _buildPostAuthHeaders,
    );
    return GetUserInfoResponse.fromJson(json);
  }

  Future<TrialsModel> fetchTrials(int age, Gender gender) async {
    var json = await _get(Routes.Trial.withArgs(age: age, gender: gender));
    return TrialsModel.fromJson(json);
  }

  Future<SecondaryResultResponse> fetchSecondaryResult(
    int trialId,
    int primaryResult,
  ) async {
    var json = await _get(Routes.TrialSecondaryResult.withArgs(
      trialId: trialId,
      primaryResult: primaryResult,
    ));
    return SecondaryResultResponse.fromJson(json);
  }

  Future<FetchOrgsResponse> fetchOrgs() async {
    var json = await _get(Routes.Organizations.toStr());
    return FetchOrgsResponse.fromJson(json);
  }

  Future<CreateOrgResponse> createOrg(Organisation org) async {
    var json = await _post(
      Routes.Organizations.toStr(),
      args: org.toJson(),
      headers: _buildPostAuthHeaders,
    );
    return CreateOrgResponse.fromJson(json);
  }

  Future updateOrg(Organisation org) async {
    await _put(
      Routes.Organization.withArgs(orgId: org.id),
      args: org.toJson(),
      headers: _buildPostAuthHeaders,
    );
  }

  Future<Organisation> getOrg(String id) async {
    var json = await _get(Routes.Organization.withArgs(orgId: id));
    return Organisation.fromJson(json);
  }

  Future deleteOrg(String id) async {
    await _delete(
      Routes.Organization.withArgs(orgId: id),
      headers: _buildAuthHeaders,
    );
  }
}
