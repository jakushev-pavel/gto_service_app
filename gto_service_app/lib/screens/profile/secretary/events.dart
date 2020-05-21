import 'package:flutter/material.dart';
import 'package:gtoserviceapp/screens/common/catalog.dart';
import 'package:gtoserviceapp/services/repo/event.dart';

class SecretaryEventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CatalogScreen(
      getData: () => EventRepo.I.getAllForSecretary(),
      title: "Мои мероприятия",
      buildInfo: (_) => Container(),
    );
  }
}
