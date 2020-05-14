import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/info/secretary.dart';
import 'package:gtoserviceapp/screens/profile/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_event_secretary.dart';
import 'package:gtoserviceapp/services/repo/secretary.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class EventSecretaryCatalogScreen extends StatelessWidget {
  final int _eventId;

  EventSecretaryCatalogScreen(this._eventId);

  @override
  Widget build(BuildContext context) {
    final String orgId = Storage.I.read(Keys.organisationId);
    return CatalogScreen<Secretary>(
      title: "Секретари мероприятия",
      getData: () => SecretaryRepo.I.getFromEvent(orgId, _eventId),
      buildInfo: (Secretary secretary) => SecretaryInfo(secretary),
      onFabPressed: _onFabPressed,
      onDeletePressed: _onDeletePressed,
    );
  }

  void _onFabPressed(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddEventSecretaryScreen(_eventId),
      ),
    );
  }

  void _onDeletePressed(Secretary secretary) {
    final String orgId = Storage.I.read(Keys.organisationId);
    SecretaryRepo.I.deleteFromEvent(
      orgId,
      _eventId,
      secretary.secretaryId,
    );
  }
}
