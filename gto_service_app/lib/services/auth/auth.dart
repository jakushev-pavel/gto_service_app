import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class Auth {
  static Auth get I {
    return GetIt.I<Auth>();
  }

  Future<bool> get isLoggedIn {
    return Storage.I.has(Keys.accessToken);
  }

  Future<void> login(String email, String password) async {
    var response = await API.I.login(email, password);

    return Future.wait([
      Storage.I.write(Keys.accessToken, response.accessToken),
      Storage.I.write(Keys.refreshToken, response.refreshToken),
      Storage.I.write(Keys.role, response.role),
      Storage.I.write(Keys.organisationID, response.organizationID.toString()),
    ]);
  }

  Future<void> logout() async {
    return Future.wait([
      Storage.I.delete(Keys.accessToken),
      Storage.I.delete(Keys.refreshToken),
      Storage.I.delete(Keys.role),
      Storage.I.delete(Keys.organisationID),
    ]);
  }
}
