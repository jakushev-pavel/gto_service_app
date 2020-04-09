import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/models.dart';
import 'package:gtoserviceapp/services/api/routes.dart';

class LocalAdminRepo {
  static LocalAdminRepo get I {
    return GetIt.I<LocalAdminRepo>();
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
