import 'package:flutter/foundation.dart';
import 'package:gtoserviceapp/models/gender.dart';

class CalculatorModel extends ChangeNotifier {
  Gender _gender;
  int _age;

  Gender get gender {
    return _gender;
  }

  set gender(Gender gender) {
    _gender = gender;
    notifyListeners();
  }

  int get age {
    return _age;
  }

  set age(int age) {
    _age = age;
    notifyListeners();
  }
}
