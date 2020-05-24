import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/text/caption.dart';
import 'package:gtoserviceapp/screens/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_participant.dart';
import 'package:gtoserviceapp/services/repo/participant.dart';
import 'package:gtoserviceapp/services/utils/utils.dart';

class EventParticipantsScreen extends StatelessWidget {
  final int eventId;

  EventParticipantsScreen({@required this.eventId});

  @override
  Widget build(BuildContext context) {
    return CatalogScreen<Participant>(
      getData: () => ParticipantRepo.I.getAllFromEvent(eventId),
      title: "Участники мероприятия",
      buildInfo: _buildInfo,
      onDeletePressed: _onDeletePressed,
      onFabPressed: _onFabPressed,
    );
  }

  Widget _buildInfo(Participant participant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(participant.name +
            " (#" +
            participant.eventParticipantId.toString() +
            ")"),
        CaptionText(participant.email),
        CaptionText(Utils.formatDate(participant.dateOfBirth)),
      ],
    );
  }

  void _onFabPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return AddParticipantScreen(eventId: eventId);
    }));
  }

  Future<void> _onDeletePressed(Participant participant) {
    return ParticipantRepo.I.deleteFromEvent(eventId, participant.eventParticipantId);
  }
}
