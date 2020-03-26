enum Tabs {
  Main,
  Calculator,
  Login,
}

extension TabsEx on Tabs {
  static Tabs fromInt(int value) {
    return {
      0: Tabs.Main,
      1: Tabs.Calculator,
      2: Tabs.Login,
    }[value];
  }

  int toInt() {
    return {
      Tabs.Main: 0,
      Tabs.Calculator: 1,
      Tabs.Login: 2,
    }[this];
  }
}
