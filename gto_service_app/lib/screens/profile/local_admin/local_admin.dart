import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/navigation/tabs.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/screens/profile/app_bar.dart';
import 'package:gtoserviceapp/screens/profile/header.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/secretary_catalog.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/sport_object_catalog.dart';

import 'events.dart';

class LocalAdminProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
      body: _buildBody(context),
      bottomNavigationBar: NavigationBar(Tabs.Profile),
    );
  }

  Widget _buildBody(context) {
    return ListView(
      children: <Widget>[
        ProfileHeader(),
        _buildEventsButton(context),
        _buildSecretaryCatalogButton(context),
        _buildSportObjectCatalogButton(context),
      ],
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
}
