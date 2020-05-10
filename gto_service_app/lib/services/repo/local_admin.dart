import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/routes.dart';

class GetLocalAdminsResponse {
  List<LocalAdmin> localAdmins;

  GetLocalAdminsResponse({this.localAdmins});

  GetLocalAdminsResponse.fromJson(List<dynamic> json) {
    if (json != null) {
      localAdmins = new List<LocalAdmin>();
      json.forEach((v) {
        localAdmins.add(new LocalAdmin.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.localAdmins != null) {
      data['adm'] = this.localAdmins.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocalAdmin {
  int userId;
  String name;
  String email;
  int roleId;
  String isActivity;
  String dateOfBirth;
  int gender;
  String registrationDate;
  String organizationId;
  int localAdminId;

  LocalAdmin(
      {this.userId,
      this.name,
      this.email,
      this.roleId,
      this.isActivity,
      this.dateOfBirth,
      this.gender,
      this.registrationDate,
      this.organizationId,
      this.localAdminId});

  LocalAdmin.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    roleId = json['roleId'];
//    isActivity = json['isActivity'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    registrationDate = json['registrationDate'];
    organizationId = json['organizationId'].toString();
    localAdminId = json['localAdminId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['roleId'] = this.roleId;
    data['isActivity'] = this.isActivity;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['registrationDate'] = this.registrationDate;
    data['organizationId'] = this.organizationId;
    data['localAdminId'] = this.localAdminId;
    return data;
  }
}

class AddLocalAdminArgs {
  String email;

  AddLocalAdminArgs({this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}

class LocalAdminRepo {
  static LocalAdminRepo get I {
    return GetIt.I<LocalAdminRepo>();
  }

  Future add(String orgId, String email) async {
    return API.I.post(
      Routes.LocalAdminExisting.withArgs(orgId: orgId),
      args: AddLocalAdminArgs(email: email).toJson(),
      auth: true,
    );
  }

  Future<List<LocalAdmin>> getAll(String orgId) async {
    var json = await API.I.get(
      Routes.LocalAdmins.withArgs(orgId: orgId),
      auth: true,
    );
    return GetLocalAdminsResponse.fromJson(json).localAdmins;
  }

  Future delete(String orgID, String localAdminId) {
    return API.I.delete(Routes.LocalAdmin.withArgs(
      orgId: orgID,
      localAdminId: localAdminId,
    ));
  }
}
