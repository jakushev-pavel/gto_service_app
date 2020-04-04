import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/navigation/tabs.dart';
import 'package:gtoserviceapp/screens/login/login.dart';
import 'package:gtoserviceapp/services/auth/auth.dart';

import 'header.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!Auth.I.isLoggedIn) {
      return LoginScreen();
    }
    return _build(context);
  }

  Widget _build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Профиль"),
        automaticallyImplyLeading: false,
        actions: <Widget>[_buildLogoutButton(context)],
      ),
      body: ProfileHeader(),
      bottomNavigationBar: NavigationBar(Tabs.Profile),
    );
  }

  Widget _buildLogoutButton(context) {
    return IconButton(
      icon: Icon(Icons.arrow_forward),
      onPressed: () => _onLogoutButtonPressed(context),
    );
  }

  _onLogoutButtonPressed(context) {
    Auth.I.logout();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => LoginScreen(),
    ));
  }
}
