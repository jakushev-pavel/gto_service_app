enum Badge {
  Bronze,
  Silver,
  Gold,
  Error,
}

extension BadgeEx on Badge {
  static Badge fromString(String str) {
    switch (str.toLowerCase()) {
      case "бронза":
        return Badge.Bronze;
      case "серебро":
        return Badge.Silver;
      case "золото":
        return Badge.Gold;
      default:
        return Badge.Error;
    }
  }
}
