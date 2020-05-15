import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/routes.dart';

class Referee {
  int id;
  int orgId;
  int userId;
  String name;
  int gender;
  String dateOfBirth;
  String email;

  Referee(
      {this.id,
      this.orgId,
      this.userId,
      this.name,
      this.gender,
      this.dateOfBirth,
      this.email});

  Referee.fromJson(Map<String, dynamic> json) {
    id = json['refereeOnOrganizationId'];
    orgId = json['organizationId'];
    userId = json['userId'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refereeOnOrganizationId'] = this.id;
    data['organizationId'] = this.orgId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['email'] = this.email;
    return data;
  }
}

class AddRefereeArgs {
  String email;

  AddRefereeArgs({this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}

class RefereeRepo {
  static RefereeRepo get I {
    return GetIt.I<RefereeRepo>();
  }

  Future add(String orgId, String email) {
    return API.I.post(
      Routes.OrgReferees.withArgs(orgId: orgId),
      auth: true,
      args: AddRefereeArgs(email: email).toJson(),
    );
  }

  Future addToTrial(int trialId, int refereeId) {
    return API.I.post(
      Routes.TrialReferee.withArgs(
        trialId: trialId,
        refereeId: refereeId.toString(),
      ),
      auth: true,
    );
  }

  Future<List<Referee>> getAll(int orgId) async {
    List<dynamic> json = await API.I.get(
      Routes.OrgReferees.withArgs(orgId: orgId.toString()),
      auth: true,
    );

    return json.map((json) => Referee.fromJson(json)).toList();
  }

  Future delete(String orgId, int refereeId) {
    return API.I.delete(
      Routes.OrgReferee.withArgs(orgId: orgId, refereeId: refereeId.toString()),
    );
  }
}
