import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/layout/expanded_horizontally.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/models.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: ExpandedHorizontally(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildUserName(context),
              _buildRole(context),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<GetUserInfoResponse> _buildUserName(context) {
    var future = API.I.getUserInfo();
    ErrorDialog.showOnFutureError(context, future);

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data.name,
            style: Theme.of(context).textTheme.headline,
          );
        }

        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildRole(context) {
    return Text(
      Storage.I.read(Keys.role),
      style: Theme.of(context).textTheme.caption,
    );
  }
}
