import 'package:flutter/cupertino.dart';

class AppModel extends ChangeNotifier {
  int _navBarSelection = 0;

  int get navBarSelection {
    return _navBarSelection;
  }

  set navBarSelection(int navBarSelection) {
    _navBarSelection = navBarSelection;
    notifyListeners();
  }
}
