enum Role {
  GlobalAdmin,
  LocalAdmin,
  User,
  Secretary,
  TeamLead,
}

extension RoleEx on Role {
  static Role fromString(String str) {
    return {
      "Глобальный администратор": Role.GlobalAdmin,
      "Локальный администратор": Role.LocalAdmin,
      "Простой пользователь": Role.User,
      "Секретарь": Role.Secretary,
      "Тренер": Role.TeamLead,
    }[str];
  }
}