import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/profile/participant_info.dart';
import 'package:gtoserviceapp/screens/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_event_participant.dart';
import 'package:gtoserviceapp/services/repo/participant.dart';

class EventParticipantsScreen extends StatelessWidget {
  final int eventId;

  EventParticipantsScreen({@required this.eventId});

  @override
  Widget build(BuildContext context) {
    return CatalogScreen<Participant>(
      getData: () => ParticipantRepo.I.getAllFromEvent(eventId),
      title: "Участники мероприятия",
      buildInfo: (participant) => ParticipantInfo(participant: participant),
      onDeletePressed: _onDeletePressed,
      onFabPressed: _onFabPressed,
    );
  }

  void _onFabPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return AddParticipantScreen(eventId: eventId);
    }));
  }

  Future<void> _onDeletePressed(Participant participant) {
    return ParticipantRepo.I.delete(participant.eventParticipantId);
  }
}
