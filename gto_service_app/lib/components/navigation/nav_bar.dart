import 'package:flutter/material.dart';
import 'package:gtoserviceapp/screens/calculator/calculator.dart';
import 'package:gtoserviceapp/screens/login/login.dart';
import 'package:gtoserviceapp/screens/main/main_screen.dart';

import 'tabs.dart';

class NavigationBar extends StatelessWidget {
  final Tabs _tab;

  NavigationBar(this._tab);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _buildItems(context),
      onTap: (value) => _onTap(context, value),
      currentIndex: _tab.toInt(),
    );
  }

  _buildItems(context) {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.rss_feed),
        title: Text("Главная"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.directions_run),
        title: Text("Калькулятор"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.vpn_key),
        title: Text("Вход"),
      ),
    ];
  }

  _onTap(BuildContext context, int value) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => _buildTab(TabsEx.fromInt(value)),
    ));
  }

  Widget _buildTab(Tabs tab) {
    switch (tab) {
      case Tabs.Main:
        return MainScreen();
        break;
      case Tabs.Calculator:
        return CalculatorScreen();
        break;
      case Tabs.Login:
        return LoginScreen();
        break;
      default:
        return null;
    }
  }
}
