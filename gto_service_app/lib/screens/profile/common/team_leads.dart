import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/text/caption.dart';
import 'package:gtoserviceapp/components/widgets/text/headline.dart';
import 'package:gtoserviceapp/models/role.dart';
import 'package:gtoserviceapp/screens/profile/common/catalog.dart';
import 'package:gtoserviceapp/services/repo/team_lead.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';
import 'package:gtoserviceapp/services/utils/utils.dart';

import 'add_team_lead.dart';

class TeamLeadsScreen extends StatefulWidget {
  final int teamId;

  TeamLeadsScreen({
    @required this.teamId,
  });

  @override
  _TeamLeadsScreenState createState() => _TeamLeadsScreenState();
}

class _TeamLeadsScreenState extends State<TeamLeadsScreen> {
  @override
  Widget build(BuildContext context) {
    bool canEdit =
        (Storage.I.role == Role.LocalAdmin || Storage.I.role == Role.Secretary);

    return CatalogScreen<TeamLead>(
      title: "Тренеры",
      getData: () => TeamLeadRepo.I.getAll(widget.teamId),
      buildInfo: _buildTeamLeadInfo,
      onFabPressed: canEdit ? _onFabPressed : null,
      onDeletePressed: canEdit ? _onDeletePressed : null,
    );
  }

  Widget _buildTeamLeadInfo(TeamLead teamLead) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeadlineText(teamLead.name),
        CaptionText(teamLead.email),
        CaptionText(Utils.formatDate(teamLead.dateOfBirth)),
      ],
    );
  }

  _onFabPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return AddTeamLeadScreen(
        teamId: widget.teamId,
        onUpdate: onUpdate,
      );
    }));
  }

  void onUpdate() {
    setState(() {});
  }

  Future<void> _onDeletePressed(TeamLead teamLead) {
    return TeamLeadRepo.I.delete(teamLead.teamLeadId);
  }
}
