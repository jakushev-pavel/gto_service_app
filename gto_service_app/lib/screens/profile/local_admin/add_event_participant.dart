import 'package:flutter/material.dart';
import 'package:gtoserviceapp/screens/common/invite_user.dart';
import 'package:gtoserviceapp/services/repo/participant.dart';

class AddParticipantScreen extends StatelessWidget {
  final int eventId;

  AddParticipantScreen({@required this.eventId});

  @override
  Widget build(BuildContext context) {
    return InviteUserScreen(
      title: "Добавление участника (личный зачет)",
      addUser: _addUser,
    );
  }

  Future _addUser(String email) {
    return ParticipantRepo.I.addToEvent(eventId, email);
  }
}
