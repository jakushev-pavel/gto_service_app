import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/text/caption.dart';
import 'package:gtoserviceapp/components/widgets/text/headline.dart';
import 'package:gtoserviceapp/screens/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_team_lead.dart';
import 'package:gtoserviceapp/services/repo/team_lead.dart';
import 'package:gtoserviceapp/services/utils/utils.dart';

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
    return CatalogScreen<TeamLead>(
      title: "Тренеры",
      getData: () => TeamLeadRepo.I.getAll(widget.teamId),
      buildInfo: _buildTeamLeadInfo,
      onFabPressed: _onFabPressed,
      onDeletePressed: _onDeletePressed,
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
