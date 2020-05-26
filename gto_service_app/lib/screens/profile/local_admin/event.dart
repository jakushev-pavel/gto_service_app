import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/components/widgets/expanded_horizontally.dart';
import 'package:gtoserviceapp/components/widgets/field.dart';
import 'package:gtoserviceapp/components/widgets/future_widget_builder.dart';
import 'package:gtoserviceapp/components/widgets/text/date.dart';
import 'package:gtoserviceapp/components/widgets/text/headline.dart';
import 'package:gtoserviceapp/models/event_state.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_edit_event.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_trial_referee.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/change_event_state.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/event_participants.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/event_secretary_catalog.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/event_trials.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/select_table.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/teams.dart';
import 'package:gtoserviceapp/services/repo/event.dart';
import 'package:gtoserviceapp/services/repo/table.dart';
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
        _buildChangeStateButton(context),
        _buildSelectTableButton(context),
        _buildTrialsButton(context),
        _buildParticipantsButton(context),
        _buildTeamsButton(context),
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
            Field("Статус", child: Text(event.state.toText())),
            _buildTableField(),
          ],
        ),
      ),
    );
  }

  FutureWidgetBuilder<ConversionTable> _buildTableField() {
    return FutureWidgetBuilder(
      TableRepo.I.getFromEvent(widget._id),
      (context, ConversionTable table) {
        return Field(
          "Таблица перевода",
          child: Text(table?.name ?? "Не выбрана"),
        );
      },
    );
  }

  _onEditPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return AddEditEventScreen(
        id: widget._id,
        onUpdate: _onUpdate,
      );
    }));
  }

  Widget _buildChangeStateButton(BuildContext context) {
    return CardPadding(
      child: Text("Изменить статус"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return ChangeEventStateScreen(
            eventId: widget._id,
            onUpdate: _onUpdate,
          );
        }));
      },
    );
  }

  Widget _buildSelectTableButton(BuildContext context) {
    return CardPadding(
      child: Text("Выбрать таблицу перевода"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return SelectTableScreen(
            eventId: widget._id,
            onUpdate: _onUpdate,
          );
        }));
      },
    );
  }

  Widget _buildTrialsButton(BuildContext context) {
    return CardPadding(
      child: Text("Виды спорта"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return EventTrialsCatalogScreen(eventId: widget._id);
        }));
      },
    );
  }

  Widget _buildParticipantsButton(BuildContext context) {
    return CardPadding(
      child: Text("Участники"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return EventParticipantsScreen(eventId: widget._id);
        }));
      },
    );
  }

  Widget _buildTeamsButton(BuildContext context) {
    return CardPadding(
      child: Text("Команды"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return EventTeamsScreen(eventId: widget._id);
        }));
      },
    );
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

  _onUpdate() {
    setState(() {});
  }
}
