import 'package:flutter/foundation.dart';

enum Gender {
  Male,
  Female,
}

extension GenderEx on Gender {
  int toInt() {
    return {
      Gender.Male: 1,
      Gender.Female: 0
    }[this];
  }
}

String genderToString(Gender gender) {
  switch (gender) {
    case Gender.Male:
      return "Мужской";
      break;
    case Gender.Female:
      return "Женский";
      break;
    default:
      throw Exception("Invalid gender value");
  }
}

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
