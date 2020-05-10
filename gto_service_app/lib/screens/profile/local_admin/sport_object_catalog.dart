import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/text/caption.dart';
import 'package:gtoserviceapp/components/text/headline.dart';
import 'package:gtoserviceapp/screens/profile/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_sport_object.dart';
import 'package:gtoserviceapp/services/repo/sport_object.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class SportObjectCatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CatalogScreen(
      title: "Спортивные объекты",
      getData: _getList,
      buildInfo: _buildSecretaryInfo,
      onDeletePressed: _onDeletePressed,
      onFabPressed: _onFabPressed,
    );
  }

  Future<List<SportObject>> _getList() {
    return SportObjectRepo.I.getAll(Storage.I.read(Keys.organisationId));
  }

  Column _buildSecretaryInfo(SportObject sportObject) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeadlineText(sportObject.name),
        CaptionText(sportObject.address),
        CaptionText(sportObject.description),
      ],
    );
  }

  _onFabPressed(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AddSportObjectScreen()),
    );
  }

  _onDeletePressed(SportObject sportObject) {
    SportObjectRepo.I.delete(
      Storage.I.read(Keys.organisationId),
      sportObject.id,
    );
  }
}
