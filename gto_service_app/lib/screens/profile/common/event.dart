import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/components/widgets/expanded_horizontally.dart';
import 'package:gtoserviceapp/components/widgets/field.dart';
import 'package:gtoserviceapp/components/widgets/future_widget_builder.dart';
import 'package:gtoserviceapp/components/widgets/text/date.dart';
import 'package:gtoserviceapp/components/widgets/text/headline.dart';
import 'package:gtoserviceapp/models/event_state.dart';
import 'package:gtoserviceapp/models/role.dart';
import 'package:gtoserviceapp/screens/profile/common/add_edit_event.dart';
import 'package:gtoserviceapp/screens/profile/common/add_trial_referee.dart';
import 'package:gtoserviceapp/screens/profile/common/teams.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/change_event_state.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/select_table.dart';
import 'package:gtoserviceapp/services/repo/event.dart';
import 'package:gtoserviceapp/services/repo/table.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

import 'event_participants.dart';
import 'event_secretaries.dart';
import 'event_trials.dart';

class EventScreen extends StatefulWidget {
  final int orgId;
  final int eventId;

  EventScreen({@required this.orgId, @required this.eventId});

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
        ..._buildButtons(context),
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
      EventRepo.I.get(widget.orgId, widget.eventId),
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

  List<Widget> _buildButtons(BuildContext context) {
    var buttons = <Widget>[];

    Role role = Storage.I.role;
    print(role.toString());
    if (role == Role.LocalAdmin) {
      buttons.add(_buildChangeStateButton(context));
    }
    buttons.add(_buildSelectTableButton(context));
    buttons.add(_buildTrialsButton(context));
    buttons.add(_buildParticipantsButton(context));
    buttons.add(_buildTeamsButton(context));
    buttons.add(_buildEventSecretaryCatalogButton(context));
    buttons.add(_buildAddRefereeButton(context));

    return buttons;
  }

  FutureWidgetBuilder<ConversionTable> _buildTableField() {
    return FutureWidgetBuilder(
      TableRepo.I.getFromEvent(widget.eventId),
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
        orgId: widget.orgId,
        eventId: widget.eventId,
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
            eventId: widget.eventId,
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
            eventId: widget.eventId,
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
          return EventTrialsScreen(
            orgId: widget.orgId,
            eventId: widget.eventId,
          );
        }));
      },
    );
  }

  Widget _buildParticipantsButton(BuildContext context) {
    return CardPadding(
      child: Text("Участники"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return EventParticipantsScreen(eventId: widget.eventId);
        }));
      },
    );
  }

  Widget _buildTeamsButton(BuildContext context) {
    return CardPadding(
      child: Text("Команды"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return EventTeamsScreen(orgId: widget.orgId, eventId: widget.eventId);
        }));
      },
    );
  }

  Widget _buildEventSecretaryCatalogButton(context) {
    return CardPadding(
      child: Text("Секретари"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return EventSecretaryCatalogScreen(
            orgId: widget.orgId,
            eventId: widget.eventId,
          );
        }));
      },
    );
  }

  Widget _buildAddRefereeButton(context) {
    return CardPadding(
      child: Text("Добавить судью"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return AddTrialRefereeScreen(
            orgId: widget.orgId,
            eventId: widget.eventId,
          );
        }));
      },
    );
  }

  _onUpdate() {
    setState(() {});
  }
}
