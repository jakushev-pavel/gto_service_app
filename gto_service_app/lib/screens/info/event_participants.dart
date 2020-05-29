import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/info/participant_info.dart';
import 'package:gtoserviceapp/models/role.dart';
import 'package:gtoserviceapp/screens/info/catalog.dart';
import 'package:gtoserviceapp/screens/info/participant_results.dart';
import 'package:gtoserviceapp/services/repo/participant.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

import '../profile/common/add_event_participant.dart';

class EventParticipantsScreen extends StatefulWidget {
  final int eventId;
  final bool editable;
  final bool resultsEditable;

  EventParticipantsScreen({
    @required this.eventId,
    bool editable,
    bool resultsEditable,
  })  : editable = editable ?? true,
        resultsEditable = resultsEditable ?? true;

  @override
  _EventParticipantsScreenState createState() =>
      _EventParticipantsScreenState();
}

class _EventParticipantsScreenState extends State<EventParticipantsScreen> {
  @override
  Widget build(BuildContext context) {
    bool canEdit = widget.editable &&
        (Storage.I.role == Role.LocalAdmin || Storage.I.role == Role.Secretary);

    return CatalogScreen<Participant>(
      getData: () => ParticipantRepo.I.getAllFromEvent(widget.eventId),
      title: "Участники мероприятия",
      buildInfo: (participant) => ParticipantInfo(
        participant: participant,
        onUpdate: _onUpdate,
        editable: widget.editable,
      ),
      onDeletePressed: canEdit ? _onDeletePressed : null,
      onFabPressed: canEdit ? _onFabPressed : null,
      onTapped: _onTapped,
    );
  }

  void _onFabPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return AddParticipantScreen(eventId: widget.eventId, onUpdate: _onUpdate);
    }));
  }

  Future<void> _onDeletePressed(Participant participant) {
    return ParticipantRepo.I.delete(participant.eventParticipantId).then((_) {
      _onUpdate();
    });
  }

  void _onUpdate() {
    setState(() {});
  }

  void _onTapped(context, Participant participant) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ParticipantResultsScreen(
        eventId: widget.eventId,
        userId: participant.userId,
        editable: widget.resultsEditable,
      );
    }));
  }
}
