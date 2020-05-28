import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/profile/event_info.dart';
import 'package:gtoserviceapp/screens/profile/common/add_edit_event.dart';
import 'package:gtoserviceapp/screens/profile/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/common/event.dart';
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
      buildInfo: (Event event) => EventInfo(event: event),
      onFabPressed: _onFabPressed,
      onTapped: _onEventTap,
      onDeletePressed: _onDeletePressed,
    );
  }

  void _onEventTap(context, Event event) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return EventScreen(eventId: event.id, orgId: Storage.I.orgId);
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
