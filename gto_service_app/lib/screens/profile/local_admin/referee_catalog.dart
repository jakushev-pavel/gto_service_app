import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/text/caption.dart';
import 'package:gtoserviceapp/components/widgets/text/headline.dart';
import 'package:gtoserviceapp/screens/profile/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/common/invite_user.dart';
import 'package:gtoserviceapp/services/repo/referee.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';
import 'package:gtoserviceapp/services/utils/utils.dart';

class RefereeCatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CatalogScreen(
      title: "Судьи",
      getData: _getData,
      buildInfo: _buildRefereeInfo,
      onFabPressed: _onFabPressed,
      onDeletePressed: _onDeletePressed,
    );
  }

  Future<List<Referee>> _getData() {
    final String orgId = Storage.I.read(Keys.organisationId);
    return RefereeRepo.I.getAll(orgId);
  }

  Widget _buildRefereeInfo(Referee referee) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeadlineText(referee.name),
        CaptionText(referee.email),
        CaptionText(Utils.formatDate(DateTime.parse(referee.dateOfBirth))),
      ],
    );
  }

  _onFabPressed(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => InviteUserScreen(
          title: "Приглашение судьи",
          addUser: (String email) {
            final String orgId = Storage.I.read(Keys.organisationId);
            return RefereeRepo.I.add(orgId, email);
          },
        ),
      ),
    );
  }

  _onDeletePressed(Referee referee) {
    final String orgId = Storage.I.read(Keys.organisationId);
    RefereeRepo.I.delete(orgId, referee.id);
  }
}
