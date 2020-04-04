import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/navigation/tabs.dart';
import 'package:gtoserviceapp/screens/login/login.dart';
import 'package:gtoserviceapp/screens/profile/app_bar.dart';
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
      appBar: ProfileAppBar(),
      body: ProfileHeader(),
      bottomNavigationBar: NavigationBar(Tabs.Profile),
    );
  }
}
