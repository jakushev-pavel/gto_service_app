import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/navigation/tabs.dart';
import 'package:gtoserviceapp/screens/login/login.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/models.dart';
import 'package:gtoserviceapp/services/auth/auth.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

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
        actions: <Widget>[_buildLogoutButton(context)],
      ),
      body: Column(
        children: <Widget>[
          _buildUserName(),
          _buildRole(),
        ],
      ),
      bottomNavigationBar: NavigationBar(Tabs.Profile),
    );
  }

  FutureBuilder<GetUserInfoResponse> _buildUserName() {
    return FutureBuilder(
      future: API.I.getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.name);
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildRole() {
    return FutureBuilder(
      future: Storage.I.read(Keys.role),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        return Text(snapshot.data);
      },
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
