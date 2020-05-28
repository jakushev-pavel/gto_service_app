import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/components/widgets/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/widgets/navigation/tabs.dart';
import 'package:gtoserviceapp/components/widgets/profile/app_bar.dart';
import 'package:gtoserviceapp/components/widgets/profile/profile_user_info.dart';
import 'package:gtoserviceapp/models/role.dart';
import 'package:gtoserviceapp/screens/login/login.dart';
import 'package:gtoserviceapp/screens/profile/global_admin/orgs.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/events.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/referee_catalog.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/secretary_catalog.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/sport_object_catalog.dart';
import 'package:gtoserviceapp/screens/profile/secretary/events.dart';
import 'package:gtoserviceapp/screens/profile/team_lead/teams.dart';
import 'package:gtoserviceapp/services/auth/auth.dart';
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
    return Scaffold(
      appBar: ProfileAppBar(),
      body: _buildBody(context),
      bottomNavigationBar: NavigationBar(Tabs.Profile),
    );
  }

  _buildBody(context) {
    return ListView(
      children: <Widget>[
        ProfileUserInfo(),
        ..._buildButtons(context),
      ],
    );
  }

  List<Widget> _buildButtons(context) {
    var buttons = <Widget>[];

    Role role = Storage.I.role;
    if (role == Role.GlobalAdmin) {
      buttons.add(_buildOrgsButton(context));
    }

    if (role == Role.LocalAdmin) {
      buttons.add(_buildEventsButton(context));
      buttons.add(_buildSecretaryCatalogButton(context));
      buttons.add(_buildRefereeCatalogButton(context));
      buttons.add(_buildSportObjectCatalogButton(context));
    }

    if (role == Role.Secretary) {
      buttons.add(_buildSecretaryEventsButton(context));
    }

    if (role == Role.TeamLead) {
      buttons.add(_buildTeamLeadTeamsButton(context));
    }
    return buttons;
  }

  Widget _buildOrgsButton(context) {
    return CardPadding(
      child: Text("Организации"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return OrgsScreen();
        }));
      },
    );
  }

  Widget _buildEventsButton(context) {
    return CardPadding(
      child: Text("Мероприятия"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return EventsScreen();
        }));
      },
    );
  }

  Widget _buildSecretaryCatalogButton(context) {
    return CardPadding(
      child: Text("Секретари"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return SecretaryCatalogScreen();
        }));
      },
    );
  }

  Widget _buildRefereeCatalogButton(context) {
    return CardPadding(
      child: Text("Судьи"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return RefereeCatalogScreen();
        }));
      },
    );
  }

  Widget _buildSportObjectCatalogButton(context) {
    return CardPadding(
      child: Text("Спортивые объекты"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return SportObjectCatalogScreen();
        }));
      },
    );
  }

  Widget _buildSecretaryEventsButton(context) {
    return CardPadding(
      child: Text("Мои мероприятия"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return SecretaryEventsScreen();
        }));
      },
    );
  }

  Widget _buildTeamLeadTeamsButton(context) {
    return CardPadding(
      child: Text("Мои команды"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return TeamLeadTeamsScreen();
        }));
      },
    );
  }
}