import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/routes.dart';

class SportObject {
  int id;
  int organizationId;
  String name;
  String address;
  String description;

  SportObject(
      {this.id,
      this.organizationId,
      this.name,
      this.address,
      this.description});

  SportObject.fromJson(Map<String, dynamic> json) {
    id = json['sportObjectId'];
    organizationId = json['organizationId'];
    name = json['name'];
    address = json['address'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sportObjectId'] = this.id;
    data['organizationId'] = this.organizationId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['description'] = this.description;
    return data;
  }
}

class SportObjectRepo {
  static SportObjectRepo get I {
    return GetIt.I<SportObjectRepo>();
  }

  Future add(String orgId, SportObject sportObject) {
    return API.I.post(
      Routes.SportObjects.withArgs(orgId: orgId),
      auth: true,
      args: sportObject.toJson(),
    );
  }

  Future<List<SportObject>> getAll(String orgId) async {
    List<dynamic> json = await API.I.get(
      Routes.SportObjects.withArgs(orgId: orgId),
      auth: true,
    );

    return json.map((json) => SportObject.fromJson(json)).toList();
  }

  Future update(String orgId, SportObject sportObject) {
    return API.I.put(
      Routes.SportObject.withArgs(
        orgId: orgId,
        sportObjectId: sportObject.id.toString(),
      ),
      sportObject.toJson(),
    );
  }

  Future delete(String orgId, int sportObjectId) {
    return API.I.delete(
      Routes.SportObject.withArgs(
        orgId: orgId,
        sportObjectId: sportObjectId.toString(),
      ),
    );
  }
}
