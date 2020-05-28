import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/widgets/info/participant_info.dart';
import 'package:gtoserviceapp/models/role.dart';
import 'package:gtoserviceapp/services/repo/participant.dart';
import 'package:gtoserviceapp/services/repo/team.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

import '../profile/common/add_team_participant.dart';
import 'catalog.dart';

class TeamParticipantsScreen extends StatefulWidget {
  final int teamId;
  final void Function() onUpdate;
  final bool editable;

  TeamParticipantsScreen({
    @required this.teamId,
    @required this.onUpdate,
    bool editable,
  }) : editable = editable ?? true;

  @override
  _TeamParticipantsScreenState createState() => _TeamParticipantsScreenState();
}

class _TeamParticipantsScreenState extends State<TeamParticipantsScreen> {
  @override
  Widget build(BuildContext context) {
    bool canConfirm = widget.editable &&
        (Storage.I.role == Role.LocalAdmin || Storage.I.role == Role.Secretary);
    bool canEdit =
        widget.editable && (canConfirm || Storage.I.role == Role.TeamLead);

    return CatalogScreen(
      title: "Участники",
      getData: () => ParticipantRepo.I.getAllFromTeam(widget.teamId),
      buildInfo: (participant) => ParticipantInfo(
        participant: participant,
        onUpdate: _onUpdate,
        editable: widget.editable,
      ),
      onFabPressed: canEdit ? _onFabPressed : null,
      onDeletePressed: canEdit ? _onDeletePressed : null,
      actions: canConfirm ? _buildActions() : null,
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
