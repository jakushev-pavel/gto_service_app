import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/models.dart';
import 'package:gtoserviceapp/services/api/routes.dart';

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
