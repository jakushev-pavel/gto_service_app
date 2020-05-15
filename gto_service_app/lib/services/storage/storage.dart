import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  SharedPreferences _prefs;

  static Storage get I {
    return GetIt.I<Storage>();
  }

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String read(Keys key) {
    return _prefs.getString(key.toStr());
  }

  bool has(Keys key) {
    return _prefs.containsKey(key.toStr());
  }

  Future write(Keys key, String value) async {
    return _prefs.setString(key.toStr(), value);
  }

  Future delete(Keys key) async {
    return _prefs.remove(key.toStr());
  }

  int get orgId {
    return int.tryParse(read(Keys.organisationId));
  }
}
