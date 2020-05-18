import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/models/gender.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/routes.dart';
import 'package:gtoserviceapp/services/utils/utils.dart';

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
  DateTime dateOfBirth;
  Gender gender;
  String registrationDate;
  String organizationId;
  int id;

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
      this.id});

  LocalAdmin.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    roleId = json['roleId'];
//    isActivity = json['isActivity'];
    dateOfBirth = DateTime.parse(json['dateOfBirth']);
    gender = GenderEx.fromInt(json['gender']);
    registrationDate = json['registrationDate'];
    organizationId = json['organizationId'].toString();
    id = json['localAdminId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['roleId'] = this.roleId;
    data['isActivity'] = this.isActivity;
    data['dateOfBirth'] = Utils.dateToJson(this.dateOfBirth);
    data['gender'] = this.gender.toInt();
    data['registrationDate'] = this.registrationDate;
    data['organizationId'] = this.organizationId;
    data['localAdminId'] = this.id;
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

  Future add(int orgId, String email) async {
    return API.I.post(
      Routes.LocalAdminExisting.withArgs(orgId: orgId),
      args: AddLocalAdminArgs(email: email).toJson(),
      auth: true,
    );
  }

  Future<List<LocalAdmin>> getAll(int orgId) async {
    var json = await API.I.get(
      Routes.LocalAdmins.withArgs(orgId: orgId),
      auth: true,
    );
    return GetLocalAdminsResponse.fromJson(json).localAdmins;
  }

  Future<LocalAdmin> get(int orgId, int localAdminId) async {
    var json = await API.I.get(
      Routes.LocalAdmin.withArgs(
        orgId: orgId,
        localAdminId: localAdminId,
      ),
    );
    return LocalAdmin.fromJson(json);
  }

  Future delete(int orgID, int localAdminId) {
    return API.I.delete(Routes.LocalAdmin.withArgs(
      orgId: orgID,
      localAdminId: localAdminId,
    ));
  }
}
