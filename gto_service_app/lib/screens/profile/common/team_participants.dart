import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/widgets/profile/participant_info.dart';
import 'package:gtoserviceapp/screens/profile/common/catalog.dart';
import 'package:gtoserviceapp/services/repo/participant.dart';
import 'package:gtoserviceapp/services/repo/team.dart';

import 'add_team_participant.dart';

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
      buildInfo: (participant) => ParticipantInfo(
        participant: participant,
        onUpdate: _onUpdate,
      ),
      onFabPressed: _onFabPressed,
      onDeletePressed: _onDeletePressed,
      actions: _buildActions(),
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
    return ParticipantRepo.I.delete(participant.eventParticipantId).then((_) {
      _onUpdate();
    });
  }

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.check),
        onPressed: _onConfirmAllPressed,
      ),
    ];
  }

  void _onConfirmAllPressed() {
    TeamRepo.I.confirm(widget.teamId).then((_) {
      _onUpdate();
    }).catchError((error) {
      showDialog(context: context, child: ErrorDialog.fromError(error));
    });
  }
}
