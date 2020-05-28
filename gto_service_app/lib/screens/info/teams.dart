import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/info/team_info.dart';
import 'package:gtoserviceapp/models/role.dart';
import 'package:gtoserviceapp/screens/info/team.dart';
import 'package:gtoserviceapp/services/repo/team.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

import '../profile/common/add_edit_team.dart';
import 'catalog.dart';

class EventTeamsScreen extends StatefulWidget {
  final int orgId;
  final int eventId;
  final bool editable;

  EventTeamsScreen({
    @required this.orgId,
    @required this.eventId,
    bool editable,
  }) : editable = editable ?? true;

  @override
  _EventTeamsScreenState createState() => _EventTeamsScreenState();
}

class _EventTeamsScreenState extends State<EventTeamsScreen> {
  @override
  Widget build(BuildContext context) {
    bool canEdit = widget.editable &&
        (Storage.I.role == Role.LocalAdmin || Storage.I.role == Role.Secretary);

    return CatalogScreen<Team>(
      title: "Команды",
      getData: () => TeamRepo.I.getAllFromEvent(widget.orgId, widget.eventId),
      buildInfo: (team) => TeamInfo(team: team),
      onFabPressed: canEdit ? _onFabPressed : null,
      onDeletePressed: canEdit ? _onDeletePressed : null,
      onTapped: _onTapped,
    );
  }

  void _onFabPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return AddEditTeamScreen(
        orgId: widget.orgId,
        eventId: widget.eventId,
        onUpdate: _onUpdate,
      );
    }));
  }

  _onUpdate() {
    setState(() {});
  }

  Future<void> _onDeletePressed(Team team) {
    print(team.toJson());
    return TeamRepo.I.delete(team.id);
  }

  void _onTapped(BuildContext context, Team team) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return TeamScreen(
        teamId: team.id,
        onUpdate: _onUpdate,
        editable: widget.editable,
      );
    }));
  }
}
