import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/profile/participant_info.dart';
import 'package:gtoserviceapp/screens/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_team_participant.dart';
import 'package:gtoserviceapp/services/repo/participant.dart';

class TeamParticipantsScreen extends StatefulWidget {
  final int teamId;
  final void Function() onUpdate;

  TeamParticipantsScreen({
    @required this.teamId,
    @required this.onUpdate,
  });

  @override
  _TeamParticipantsScreenState createState() => _TeamParticipantsScreenState();
}

class _TeamParticipantsScreenState extends State<TeamParticipantsScreen> {
  @override
  Widget build(BuildContext context) {
    return CatalogScreen(
      title: "Участники",
      getData: () => ParticipantRepo.I.getAllFromTeam(widget.teamId),
      buildInfo: (participant) => ParticipantInfo(participant: participant),
      onFabPressed: _onFabPressed,
      onDeletePressed: _onDeletePressed,
    );
  }

  _onFabPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return AddTeamParticipantScreen(
        teamId: widget.teamId,
        onUpdate: _onUpdate,
      );
    }));
  }

  void _onUpdate() {
    widget.onUpdate();
    setState(() {});
  }

  Future<void> _onDeletePressed(Participant participant) {
    return ParticipantRepo.I.delete(participant.eventParticipantId);
  }
}
