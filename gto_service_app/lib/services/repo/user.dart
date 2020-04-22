import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/models/gender.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/routes.dart';
import 'package:gtoserviceapp/services/utils/utils.dart';

class InviteUserArgs {
  String name;
  String email;
  DateTime dateOfBirth;
  Gender gender;

  InviteUserArgs({this.name, this.email, this.dateOfBirth, this.gender});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['dateOfBirth'] = Utils.dateToJson(this.dateOfBirth);
    data['gender'] = this.gender.toInt();
    return data;
  }
}

class UserRepo {
  static UserRepo get I {
    return GetIt.I<UserRepo>();
  }

  Future invite(InviteUserArgs args) async {
    return API.I.post(
      Routes.Invite.toStr(),
      args: args.toJson(),
      auth: true,
    );
  }
}
