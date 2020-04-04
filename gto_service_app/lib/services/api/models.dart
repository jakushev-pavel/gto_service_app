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

