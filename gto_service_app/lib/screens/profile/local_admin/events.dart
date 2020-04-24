import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/failure/failure.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
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
    return FutureBuilder<List<Event>>(
      future: EventRepo.I.getAll(Storage.I.read(Keys.organisationId)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildEventList(context, snapshot.data);
        }
        if (snapshot.hasError) {
          return Failure(snapshot.error);
        }

        return SizedBox.shrink(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildEventList(context, List<Event> events) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: events.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: _buildEvent(context, events[index]),
        );
      },
    );
  }

  Widget _buildEvent(context, Event event) {
    return InkWell(
      onTap: () => _onEventTap(context, event.id),
      child: CardPadding(
        margin: ListMargin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(event.name),
            Text(
              event.description,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }

  void _onEventTap(context, int eventId) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return EventScreen(eventId);
    }));
  }

  _onFabPressed(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return AddEditEventScreen();
    }));
  }
}
