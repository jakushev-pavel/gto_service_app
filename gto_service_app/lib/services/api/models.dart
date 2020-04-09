class LoginArgs {
  String email;
  String password;

  LoginArgs({this.email, this.password})
      : assert(email != null),
        assert(password != null);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}

class LoginResponse {
  String accessToken;
  String refreshToken;
  String role;
  int organizationID;
  int userID;

  LoginResponse(
      {this.accessToken, this.refreshToken, this.role, this.organizationID});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    role = json['role'];
    organizationID = json['organizationId'];
    userID = json['userId'];
  }
}

class RefreshResponse {
  String accessToken;
  String refreshToken;

  RefreshResponse({this.accessToken, this.refreshToken});

  RefreshResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }
}

class GetUserInfoResponse {
  String email;
  String name;
  String gender;
  String dateOfBirth;

  GetUserInfoResponse({this.email, this.name, this.gender, this.dateOfBirth});

  GetUserInfoResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
  }
}

class SecondaryResultResponse {
  int secondaryResult;

  SecondaryResultResponse({this.secondaryResult});

  SecondaryResultResponse.fromJson(Map<String, dynamic> json) {
    secondaryResult = json['secondResult'];
  }
}

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
  String id;
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
    id = json['id'];
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
