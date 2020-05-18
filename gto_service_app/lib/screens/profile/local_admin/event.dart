import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/components/widgets/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/widgets/dialogs/yes_no_dialog.dart';
import 'package:gtoserviceapp/components/widgets/expanded_horizontally.dart';
import 'package:gtoserviceapp/components/widgets/field.dart';
import 'package:gtoserviceapp/components/widgets/future_widget_builder.dart';
import 'package:gtoserviceapp/components/widgets/text/date.dart';
import 'package:gtoserviceapp/components/widgets/text/headline.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_edit_event.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_trial_referee.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/event_secretary_catalog.dart';
import 'package:gtoserviceapp/services/repo/event.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class EventScreen extends StatefulWidget {
  final int _id;

  EventScreen(this._id);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildFutureEventCard(context),
        _buildEventSecretaryCatalogButton(context),
        _buildAddRefereeButton(context),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Мероприятие"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => _onEditPressed(context),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _onDeletePressed(context),
        ),
      ],
    );
  }

  Widget _buildFutureEventCard(context) {
    return FutureWidgetBuilder(
      EventRepo.I.get(Storage.I.orgId, widget._id),
      _buildEventCard,
    );
  }

  Widget _buildEventCard(context, Event event) {
    return ExpandedHorizontally(
      child: CardPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeadlineText(event.name),
            Text(event.description),
            Row(
              children: <Widget>[
                Field("Начало", child: DateText(event.startDate)),
                SizedBox(width: 16),
                Field("Конец", child: DateText(event.expirationDate)),
              ],
            ),
            Field("Статус", child: Text(event.status)),
          ],
        ),
      ),
    );
  }

  _onEditPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return AddEditEventScreen(id: widget._id);
    }));
  }

  _onDeletePressed(context) {
    showDialog(
        context: context,
        child: YesNoDialog("Удалить мероприятие?", () async {
          var future = EventRepo.I.delete(Storage.I.orgId, widget._id);
          ErrorDialog.showOnFutureError(context, future);
          await future;

          Navigator.of(context).pop();
        }));
  }

  Widget _buildEventSecretaryCatalogButton(context) {
    return CardPadding(
      child: Text("Секретари"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return EventSecretaryCatalogScreen(widget._id);
        }));
      },
    );
  }

  Widget _buildAddRefereeButton(context) {
    return CardPadding(
      child: Text("Добавить судью"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return AddTrialRefereeScreen(eventId: widget._id);
        }));
      },
    );
  }
}
