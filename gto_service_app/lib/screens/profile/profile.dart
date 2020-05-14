import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/widgets/navigation/tabs.dart';
import 'package:gtoserviceapp/components/widgets/profile/app_bar.dart';
import 'package:gtoserviceapp/models/role.dart';
import 'package:gtoserviceapp/screens/login/login.dart';
import 'package:gtoserviceapp/screens/profile/global_admin/global_admin.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/local_admin.dart';
import 'package:gtoserviceapp/services/auth/auth.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!Auth.I.isLoggedIn) {
      return LoginScreen();
    }
    return _build(context);
  }

  Widget _build(context) {
    var roleStr = Storage.I.read(Keys.role);
    var role = RoleEx.fromString(roleStr);
    switch (role) {
      case Role.GlobalAdmin:
        return GlobalAdminProfileScreen();
      case Role.LocalAdmin:
        return LocalAdminProfileScreen();
      default:
        return _buildUnsupportedRole();
    }
  }

  _buildUnsupportedRole() {
    return Scaffold(
      appBar: ProfileAppBar(),
      body: Text("Роль не поддерживается"),
      bottomNavigationBar: NavigationBar(Tabs.Profile),
    );
  }
}
