import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/routes.dart';

class Secretary {
  int secretaryOnOrganizationId;
  int organizationId;
  int userId;
  String name;
  int gender;
  String dateOfBirth;
  String email;

  Secretary(
      {this.secretaryOnOrganizationId,
      this.organizationId,
      this.userId,
      this.name,
      this.gender,
      this.dateOfBirth,
      this.email});

  Secretary.fromJson(Map<String, dynamic> json) {
    secretaryOnOrganizationId = json['secretaryOnOrganizationId'];
    organizationId = json['organizationId'];
    userId = json['userId'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['secretaryOnOrganizationId'] = this.secretaryOnOrganizationId;
    data['organizationId'] = this.organizationId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['email'] = this.email;
    return data;
  }
}

class SecretaryRepo {
  static SecretaryRepo get I {
    return GetIt.I<SecretaryRepo>();
  }

  Future<List<Secretary>> getFromOrg(String orgId) async {
    List json = await API.I.get(
      Routes.OrgSecretaries.withArgs(orgId: orgId),
      auth: true,
    );
    json ??= [];
    return json.map((jsonValue) => Secretary.fromJson(jsonValue)).toList();
  }

  Future<List<Secretary>> getFromEvent(String orgId, int eventId) async {
    List json = await API.I.get(
      Routes.EventSecretaries.withArgs(orgId: orgId, eventId: eventId.toString()),
      auth: true,
    );
    json ??= [];
    return json.map((jsonValue) => Secretary.fromJson(jsonValue)).toList();
  }
}
