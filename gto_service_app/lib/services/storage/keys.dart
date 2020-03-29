enum Keys {
  accessToken,
  refreshToken,
  role,
  organisationID,
}

extension KeysEx on Keys {
  String toStr() {
    return {
      Keys.accessToken: "accessToken",
      Keys.refreshToken: "refreshToken",
      Keys.role: "role",
      Keys.organisationID: "organisationID",
    }[this];
  }
}