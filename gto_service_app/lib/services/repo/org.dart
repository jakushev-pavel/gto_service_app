import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/routes.dart';

class FetchOrgsResponse {
  List<Organisation> organisations;

  FetchOrgsResponse.fromJson(List<dynamic> json) {
    if (json != null) {
      organisations = new List<Organisation>();
      json.forEach((v) {
        organisations.add(new Organisation.fromJson(v));
      });
    }
  }
}

class Organisation {
  int id;
  String name;
  String address;
  String leader;
  String phoneNumber;
  String oQRN;
  String paymentAccount;
  String branch;
  String bik;
  String correspondentAccount;
  int countOfAllEvents;
  int countOfActiveEvents;

  Organisation(
      {this.id,
      this.name,
      this.address,
      this.leader,
      this.phoneNumber,
      this.oQRN,
      this.paymentAccount,
      this.branch,
      this.bik,
      this.correspondentAccount,
      this.countOfAllEvents,
      this.countOfActiveEvents});

  Organisation.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']);
    name = json['name'];
    address = json['address'];
    leader = json['leader'];
    phoneNumber = json['phone_number'];
    phoneNumber ??= json['phoneNumber'];
    oQRN = json['OQRN'];
    paymentAccount = json['payment_account'];
    branch = json['branch'];
    bik = json['bik'];
    correspondentAccount = json['correspondent_account'];
    countOfAllEvents = json['countOfAllEvents'];
    countOfActiveEvents = json['countOfActiveEvents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['leader'] = this.leader;
    data['phoneNumber'] = this.phoneNumber;
    data['oqrn'] = this.oQRN;
    data['OQRN'] = this.oQRN;
    data['paymentAccount'] = this.paymentAccount;
    data['payment_account'] = this.paymentAccount;
    data['branch'] = this.branch;
    data['bik'] = this.bik;
    data['correspondentAccount'] = this.correspondentAccount;
    data['correspondent_account'] = this.correspondentAccount;
    data['leader'] = this.leader;
    data['countOfAllEvents'] = this.countOfAllEvents;
    data['countOfActiveEvents'] = this.countOfActiveEvents;
    return data;
  }
}

class CreateOrgResponse {
  int id;

  CreateOrgResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
}

class OrgRepo {
  static OrgRepo get I {
    return GetIt.I<OrgRepo>();
  }

  Future<CreateOrgResponse> add(Organisation org) async {
    var json = await API.I.post(
      Routes.Organizations.toStr(),
      args: org.toJson(),
      auth: true,
    );
    return CreateOrgResponse.fromJson(json);
  }

  Future<Organisation> get(int orgId) async {
    var json = await API.I.get(Routes.Organization.withArgs(orgId: orgId));
    return Organisation.fromJson(json);
  }

  Future<FetchOrgsResponse> getAll() async {
    var json = await API.I.get(Routes.Organizations.toStr());
    return FetchOrgsResponse.fromJson(json);
  }

  Future update(Organisation org) async {
    await API.I.put(Routes.Organization.withArgs(orgId: org.id), org.toJson());
  }

  Future delete(int orgId) async {
    await API.I.delete(Routes.Organization.withArgs(orgId: orgId));
  }
}
