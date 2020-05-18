import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/widgets/text/caption.dart';
import 'package:gtoserviceapp/components/widgets/text/headline.dart';
import 'package:gtoserviceapp/screens/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_edit_sport_object.dart';
import 'package:gtoserviceapp/services/repo/sport_object.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class SportObjectCatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CatalogScreen<SportObject>(
      title: "Спортивные объекты",
      getData: _getList,
      buildInfo: _buildSecretaryInfo,
      onDeletePressed: _onDeletePressed(context),
      onFabPressed: _onFabPressed,
      onEditPressed: _onEditPressed(context),
    );
  }

  Future<List<SportObject>> _getList() {
    return SportObjectRepo.I.getAll(Storage.I.orgId);
  }

  Widget _buildSecretaryInfo(SportObject sportObject) {
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

  _onDeletePressed(context) {
    return (SportObject sportObject) {
      var future = SportObjectRepo.I.delete(
        Storage.I.orgId,
        sportObject.id,
      );
      ErrorDialog.showOnFutureError(context, future);
    };
  }

  _onEditPressed(context) {
    return (SportObject sportObject) {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => AddSportObjectScreen(sportObject: sportObject)),
      );
    };
  }
}
