import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/navigation/tabs.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/screens/profile/app_bar.dart';
import 'package:gtoserviceapp/screens/profile/header.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/secretary_catalog.dart';

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
      ],
    );
  }

  Widget _buildEventsButton(context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return EventsScreen();
        }));
      },
      child: CardPadding(child: Text("Мероприятия")),
    );
  }

  Widget _buildSecretaryCatalogButton(context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return SecretaryCatalogScreen();
        }));
      },
      child: CardPadding(child: Text("Секретари")),
    );
  }
}
