import 'package:flutter/material.dart';
import 'package:gtoserviceapp/screens/common/catalog.dart';
import 'package:gtoserviceapp/screens/common/invite_user.dart';
import 'package:gtoserviceapp/services/repo/referee.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

import 'file:///C:/Users/Acer/Documents/Dev/gto_service_app/gto_service_app/lib/components/widgets/profile/referee_info.dart';

class RefereeCatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CatalogScreen<Referee>(
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
            return RefereeRepo.I.add(Storage.I.orgId, email);
          },
        ),
      ),
    );
  }

  Future<void> _onDeletePressed(Referee referee) {
    return RefereeRepo.I.delete(Storage.I.orgId, referee.id);
  }
}
