import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/navigation/tabs.dart';
import 'package:gtoserviceapp/screens/login/login.dart';
import 'package:gtoserviceapp/services/auth/auth.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Auth.I.isLoggedIn,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.data) {
          return LoginScreen();
        }
        return _build(context);
      },
    );
  }

  Widget _build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Профиль"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () => _onLogoutButtonPressed(context),
          )
        ],
      ),
      bottomNavigationBar: NavigationBar(Tabs.Profile),
    );
  }

  _onLogoutButtonPressed(context) {
    Auth.I.logout();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => LoginScreen(),
    ));
  }
}
