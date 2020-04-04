enum Keys {
  accessToken,
  refreshToken,
  role,
  organisationId,
  userId,
}

extension KeysEx on Keys {
  String toStr() {
    return {
      Keys.accessToken: "accessToken",
      Keys.refreshToken: "refreshToken",
      Keys.role: "role",
      Keys.organisationId: "organisationId",
      Keys.userId: "userId",
    }[this];
  }
}
