enum Tabs {
  Main,
  Calculator,
}

extension TabsEx on Tabs {
  static Tabs fromInt(int value) {
    return {
      0: Tabs.Main,
      1: Tabs.Calculator,
    }[value];
  }

  int toInt() {
    return {
      Tabs.Main: 0,
      Tabs.Calculator: 1,
    }[this];
  }
}
