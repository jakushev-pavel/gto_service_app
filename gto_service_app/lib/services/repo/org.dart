import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/models.dart';
import 'package:gtoserviceapp/services/api/routes.dart';

class OrgRepo {
  static OrgRepo get I {
    return GetIt.I<OrgRepo>();
  }

  Future<CreateOrgResponse> create(Organisation org) async {
    var json = await API.I.post(
      Routes.Organizations.toStr(),
      args: org.toJson(),
      auth: true,
    );
    return CreateOrgResponse.fromJson(json);
  }

  Future<Organisation> get(String id) async {
    var json = await API.I.get(Routes.Organization.withArgs(orgId: id));
    return Organisation.fromJson(json);
  }

  Future<FetchOrgsResponse> getAll() async {
    var json = await API.I.get(Routes.Organizations.toStr());
    return FetchOrgsResponse.fromJson(json);
  }

  Future update(Organisation org) async {
    await API.I.put(Routes.Organization.withArgs(orgId: org.id), org.toJson());
  }

  Future delete(String id) async {
    await API.I.delete(Routes.Organization.withArgs(orgId: id));
  }
}
