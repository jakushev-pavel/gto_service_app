enum Gender {
  Male,
  Female,
}

extension GenderEx on Gender {
  int toInt() {
    return {
      Gender.Male: 1,
      Gender.Female: 0,
    }[this];
  }

  String toStr() {
    return {
      Gender.Male: "Мужской",
      Gender.Female: "Женский",
    }[this];
  }
}
