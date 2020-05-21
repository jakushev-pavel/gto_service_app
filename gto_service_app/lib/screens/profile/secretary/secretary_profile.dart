import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/components/widgets/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/widgets/navigation/tabs.dart';
import 'package:gtoserviceapp/components/widgets/profile/app_bar.dart';
import 'package:gtoserviceapp/components/widgets/profile/profile_user_info.dart';
import 'package:gtoserviceapp/screens/profile/secretary/events.dart';

class SecretaryProfileScreen extends StatelessWidget {
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
        ProfileUserInfo(),
        _buildEventsButton(context),
      ],
    );
  }

  Widget _buildEventsButton(context) {
    return CardPadding(
      child: Text("Мероприятия"),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SecretaryEventsScreen(),
          ),
        );
      },
    );
  }
}
