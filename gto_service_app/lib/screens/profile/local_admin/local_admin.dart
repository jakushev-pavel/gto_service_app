import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/failure/failure.dart';
import 'package:gtoserviceapp/components/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/navigation/tabs.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/models/event.dart';
import 'package:gtoserviceapp/screens/profile/app_bar.dart';
import 'package:gtoserviceapp/screens/profile/header.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/event.dart';
import 'package:gtoserviceapp/services/repo/event.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class LocalAdminProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
      body: _buildBody(context),
      bottomNavigationBar: NavigationBar(Tabs.Profile),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(context) {
    return ListView(
      children: <Widget>[
        ProfileHeader(),
        _buildEventListHeader(context),
        _buildFutureEventList(context),
      ],
    );
  }

  Widget _buildEventListHeader(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Text(
        "Мероприятия:",
        style: Theme.of(context).textTheme.headline,
      ),
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
}
