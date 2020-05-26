import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/profile/participant_info.dart';
import 'package:gtoserviceapp/screens/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_event_participant.dart';
import 'package:gtoserviceapp/services/repo/participant.dart';

class EventParticipantsScreen extends StatefulWidget {
  final int eventId;

  EventParticipantsScreen({@required this.eventId});

  @override
  _EventParticipantsScreenState createState() =>
      _EventParticipantsScreenState();
}

class _EventParticipantsScreenState extends State<EventParticipantsScreen> {
  @override
  Widget build(BuildContext context) {
    return CatalogScreen<Participant>(
      getData: () => ParticipantRepo.I.getAllFromEvent(widget.eventId),
      title: "Участники мероприятия",
      buildInfo: (participant) => ParticipantInfo(
        participant: participant,
        onUpdate: _onUpdate,
      ),
      onDeletePressed: _onDeletePressed,
      onFabPressed: _onFabPressed,
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
}
