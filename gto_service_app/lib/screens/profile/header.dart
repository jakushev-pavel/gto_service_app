import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/failure/failure.dart';
import 'package:gtoserviceapp/components/layout/expanded_horizontally.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/models.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CardPadding(
      child: ExpandedHorizontally(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildFutureUserName(context),
            _buildRole(context),
          ],
        ),
      ),
    );
  }

  FutureBuilder<GetUserInfoResponse> _buildFutureUserName(context) {
    return FutureBuilder(
      future: API.I.getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildUserName(snapshot, context);
        }
        if (snapshot.hasError) {
          return Failure(snapshot.error);
        }

        return CircularProgressIndicator();
      },
    );
  }

  Text _buildUserName(
      AsyncSnapshot<GetUserInfoResponse> snapshot, BuildContext context) {
    return Text(
      snapshot.data.name,
      style: Theme.of(context).textTheme.headline,
    );
  }

  Widget _buildRole(context) {
    return Text(
      Storage.I.read(Keys.role),
      style: Theme.of(context).textTheme.caption,
    );
  }
}
