import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/info/secretary.dart';
import 'package:gtoserviceapp/screens/profile/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/common/invite_user.dart';
import 'package:gtoserviceapp/services/repo/secretary.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class SecretaryCatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CatalogScreen<Secretary>(
      title: "Секретари",
      getData: _getList,
      buildInfo: (data) => SecretaryInfo(data),
      onDeletePressed: _onDeletePressed,
      onFabPressed: _onFabPressed,
    );
  }

  Future<List<Secretary>> _getList() {
    return SecretaryRepo.I.getFromOrg(Storage.I.read(Keys.organisationId));
  }

  _onFabPressed(context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => InviteUserScreen(
        title: "Приглашение секретаря",
        addUser: (String email) {
          return SecretaryRepo.I
              .addToOrg(Storage.I.read(Keys.organisationId), email);
        },
      ),
    ));
  }

  _onDeletePressed(Secretary secretary) {
    SecretaryRepo.I.deleteFromOrg(
      Storage.I.read(Keys.organisationId),
      secretary.secretaryOnOrganizationId,
    );
  }
}
