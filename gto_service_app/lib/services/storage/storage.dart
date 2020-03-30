import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';

class Storage {
  FlutterSecureStorage _storage = FlutterSecureStorage();

  static Storage get I {
    return GetIt.I<Storage>();
  }

  Future<String> read(Keys key) async {
    return _storage.read(key: key.toStr());
  }

  Future<bool> has(Keys key) async {
    return (await read(key)) != null;
  }

  Future write(Keys key, String value) async {
    return _storage.write(key: key.toStr(), value: value);
  }

  Future delete(Keys key) async {
    return _storage.delete(key: key.toStr());
  }
}
