import 'package:flutter/material.dart';
import 'package:gtoserviceapp/models/event.dart';
import 'package:gtoserviceapp/screens/profile/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_edit_event.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/event.dart';
import 'package:gtoserviceapp/services/repo/event.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CatalogScreen<Event>(
      getData: () => EventRepo.I.getAll(Storage.I.orgId),
      title: "Мероприятия",
      buildInfo: _buildEvent(context),
      onFabPressed: _onFabPressed,
      onTapped: _onEventTap,
    );
  }

  Widget Function(Event event) _buildEvent(context) {
    return (Event event) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(event.name),
          Text(
            event.description,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      );
    };
  }

  void _onEventTap(context, Event event) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return EventScreen(event.id);
    }));
  }

  _onFabPressed(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return AddEditEventScreen();
    }));
  }
}
