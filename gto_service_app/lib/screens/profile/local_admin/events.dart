import 'package:flutter/material.dart';
import 'package:gtoserviceapp/screens/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_edit_event.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/event.dart';
import 'package:gtoserviceapp/services/repo/event.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    return CatalogScreen<Event>(
      getData: () => EventRepo.I.getAllFromOrg(Storage.I.orgId),
      title: "Мероприятия",
      buildInfo: _buildEvent(context),
      onFabPressed: _onFabPressed,
      onTapped: _onEventTap,
      onDeletePressed: _onDeletePressed,
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
      return AddEditEventScreen(onUpdate: _onUpdate);
    }));
  }

  Future<void> _onDeletePressed(Event event) {
    return EventRepo.I.delete(Storage.I.orgId, event.id);
  }

  void _onUpdate() {
    setState(() {});
  }
}
