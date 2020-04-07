import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/navigation/tabs.dart';
import 'package:gtoserviceapp/screens/profile/app_bar.dart';
import 'package:gtoserviceapp/screens/profile/global_admin/add_edit_org.dart';
import 'package:gtoserviceapp/screens/profile/global_admin/org.dart';
import 'package:gtoserviceapp/screens/profile/header.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/models.dart';

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
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Text(
        "Организации:",
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }

  Widget _buildFutureOrgList(context) {
    var response = API.I.fetchOrgs();
    ErrorDialog.showOnFutureError(context, response);

    return FutureBuilder<FetchOrgsResponse>(
      future: response,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildOrgList(context, snapshot.data.organisations);
        }

        return SizedBox.shrink(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildOrgList(context, List<Organisation> orgs) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: orgs.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: _buildOrg(context, orgs[index]),
        );
      },
    );
  }

  Widget _buildOrg(context, Organisation org) {
    return InkWell(
      onTap: () => _onOrgTapped(context, org.id),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(org.name),
              Text(
                org.address,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onFabPressed(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return AddEditOrgScreen();
    }));
  }

  _onOrgTapped(context, String id) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => OrganisationScreen(id),
    ));
  }
}
