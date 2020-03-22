import 'package:flutter/material.dart';
import 'package:gtoserviceapp/models/app_model.dart';
import 'package:gtoserviceapp/screens/calculator/calculator.dart';
import 'package:gtoserviceapp/screens/main/main_screen.dart';
import 'package:provider/provider.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appModel = Provider.of<AppModel>(context);
    return BottomNavigationBar(
      items: _buildItems(context),
      onTap: (value) => _onTap(context, value),
      currentIndex: appModel.navBarSelection,
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
    ];
  }

  _onTap(BuildContext context, int value) {
    var appModel = Provider.of<AppModel>(context, listen: false);
    appModel.navBarSelection = value;
    switch (value) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MainScreen(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CalculatorScreen(),
        ));
        break;
    }
  }
}
