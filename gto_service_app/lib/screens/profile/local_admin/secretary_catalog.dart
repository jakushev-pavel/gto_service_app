import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/text/caption.dart';
import 'package:gtoserviceapp/components/widgets/text/headline.dart';
import 'package:gtoserviceapp/screens/profile/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/common/invite_user.dart';
import 'package:gtoserviceapp/services/repo/secretary.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';
import 'package:gtoserviceapp/services/utils/utils.dart';

class SecretaryCatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CatalogScreen(
      title: "Секретари",
      getData: _getList,
      buildInfo: _buildSecretaryInfo,
      onDeletePressed: _onDeletePressed,
      onFabPressed: _onFabPressed,
    );
  }

  Future<List<Secretary>> _getList() {
    return SecretaryRepo.I.getFromOrg(Storage.I.read(Keys.organisationId));
  }

  Column _buildSecretaryInfo(Secretary secretary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeadlineText(secretary.name),
        CaptionText(secretary.email),
        CaptionText(Utils.formatDate(DateTime.parse(secretary.dateOfBirth))),
      ],
    );
  }

  _onFabPressed(context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => InviteUserScreen(
        title: "Приглашение секретаря",
        addUser: (String email) {
          return SecretaryRepo.I
              .add(Storage.I.read(Keys.organisationId), email);
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
