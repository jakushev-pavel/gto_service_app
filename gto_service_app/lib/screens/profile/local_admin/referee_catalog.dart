import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/info/referee.dart';
import 'package:gtoserviceapp/screens/profile/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/common/invite_user.dart';
import 'package:gtoserviceapp/services/repo/referee.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class RefereeCatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CatalogScreen(
      title: "Судьи",
      getData: _getData,
      buildInfo: (Referee referee) => RefereeInfo(referee),
      onFabPressed: _onFabPressed,
      onDeletePressed: _onDeletePressed,
    );
  }

  Future<List<Referee>> _getData() {
    return RefereeRepo.I.getAll(Storage.I.orgId);
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
