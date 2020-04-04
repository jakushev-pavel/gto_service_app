import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/layout/expanded_horizontally.dart';
import 'package:gtoserviceapp/components/layout/shrunk_vertically.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/models.dart';

class OrganisationScreen extends StatelessWidget {
  final String _id;

  OrganisationScreen(this._id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Организация")),
      body: _buildFutureOrg(context),
    );
  }

  Widget _buildFutureOrg(context) {
    var org = API.I.getOrg(_id);
    ErrorDialog.showOnFutureError(context, org);

    return FutureBuilder(
      future: org,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _buildOrg(snapshot.data);
        }

        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildOrg(Organisation org) {
    return ShrunkVertically(
      child: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ExpandedHorizontally(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(org.name ?? ""),
                Text(org.address ?? ""),
                Text(org.leader ?? ""),
                Text(org.oQRN ?? ""),
                Text(org.correspondentAccount ?? ""),
                Text(org.bik ?? ""),
                Text(org.branch ?? ""),
                Text(org.phoneNumber ?? ""),
                Text(org.paymentAccount ?? ""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
