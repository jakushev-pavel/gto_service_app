import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/profile/team_info.dart';
import 'package:gtoserviceapp/screens/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_team.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/team.dart';
import 'package:gtoserviceapp/services/repo/team.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class EventTeamsScreen extends StatefulWidget {
  final int eventId;

  EventTeamsScreen({@required this.eventId});

  @override
  _EventTeamsScreenState createState() => _EventTeamsScreenState();
}

class _EventTeamsScreenState extends State<EventTeamsScreen> {
  @override
  Widget build(BuildContext context) {
    return CatalogScreen<Team>(
      title: "Команды",
      getData: () =>
          TeamRepo.I.getAllFromEvent(Storage.I.orgId, widget.eventId),
      buildInfo: (team) => TeamInfo(team: team),
      onFabPressed: _onFabPressed,
      onDeletePressed: _onDeletePressed,
      onTapped: _onTapped,
    );
  }

  void _onFabPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return AddTeamScreen(
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
        id: team.id,
        onUpdate: _onUpdate,
      );
    }));
  }
}
