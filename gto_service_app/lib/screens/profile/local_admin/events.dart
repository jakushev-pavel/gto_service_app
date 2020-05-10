import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/card_list_view.dart';
import 'package:gtoserviceapp/components/widgets/future_widget_builder.dart';
import 'package:gtoserviceapp/models/event.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_edit_event.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/event.dart';
import 'package:gtoserviceapp/services/repo/event.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Мероприятия"),
      ),
      body: _buildFutureEventList(context),
      floatingActionButton: _buildFab(context),
    );
  }

  FloatingActionButton _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _onFabPressed(context),
      child: Icon(Icons.add),
    );
  }

  Widget _buildFutureEventList(context) {
    return FutureWidgetBuilder(
        EventRepo.I.getAll(Storage.I.read(Keys.organisationId)),
        _buildEventList);
  }

  Widget _buildEventList(context, List<Event> events) {
    return CardListView(
      events,
      _buildEvent,
      onTap: _onEventTap,
    );
  }

  Widget _buildEvent(context, Event event) {
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
