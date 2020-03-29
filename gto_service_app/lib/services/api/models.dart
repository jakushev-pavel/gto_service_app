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

  LoginResponse(
      {this.accessToken, this.refreshToken, this.role, this.organizationID});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    role = json['role'];
    organizationID = json['organizationId'];
  }
}
