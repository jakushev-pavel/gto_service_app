import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/card_list_view.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/components/widgets/future_widget_builder.dart';
import 'package:gtoserviceapp/components/widgets/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/widgets/navigation/tabs.dart';
import 'package:gtoserviceapp/screens/profile/app_bar.dart';
import 'package:gtoserviceapp/screens/profile/global_admin/add_edit_org.dart';
import 'package:gtoserviceapp/screens/profile/global_admin/org.dart';
import 'package:gtoserviceapp/screens/profile/header.dart';
import 'package:gtoserviceapp/services/repo/org.dart';

class GlobalAdminProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
      body: _buildBody(context),
      bottomNavigationBar: NavigationBar(Tabs.Profile),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onFabPressed(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(context) {
    return ListView(
      children: <Widget>[
        ProfileHeader(),
        _buildOrgListHeader(context),
        _buildFutureOrgList(context),
      ],
    );
  }

  Widget _buildOrgListHeader(context) {
    return Padding(
      padding: DefaultMargin,
      child: Text(
        "Организации:",
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }

  Widget _buildFutureOrgList(context) {
    return FutureWidgetBuilder(
      OrgRepo.I.getAll(),
      (context, FetchOrgsResponse response) =>
          _buildOrgList(context, response.organisations),
    );
  }

  Widget _buildOrgList(context, List<Organisation> orgs) {
    return CardListView(orgs, _buildOrg, onTap: _onOrgTapped);
  }

  Widget _buildOrg(BuildContext context, Organisation org) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(org.name),
        Text(
          org.address,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }

  _onFabPressed(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return AddEditOrgScreen();
    }));
  }

  _onOrgTapped(context, Organisation org) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => OrganisationScreen(org.id),
    ));
  }
}
