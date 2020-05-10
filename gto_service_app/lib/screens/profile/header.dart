import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/future_widget_builder/future_widget_builder.dart';
import 'package:gtoserviceapp/components/layout/expanded_horizontally.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/services/repo/user.dart';
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

  Widget _buildFutureUserName(context) {
    return FutureWidgetBuilder(UserRepo.I.getUserInfo(), _buildUserName);
  }

  Text _buildUserName(context, GetUserInfoResponse response) {
    return Text(
      response.name,
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
