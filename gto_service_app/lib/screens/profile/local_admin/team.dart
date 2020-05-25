import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/components/widgets/expanded_horizontally.dart';
import 'package:gtoserviceapp/components/widgets/future_widget_builder.dart';
import 'package:gtoserviceapp/components/widgets/profile/team_info.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/team_leads.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/team_participants.dart';
import 'package:gtoserviceapp/services/repo/team.dart';

class TeamScreen extends StatefulWidget {
  final int id;
  final void Function() onUpdate;

  TeamScreen({
    @required this.id,
    @required this.onUpdate,
  });

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Команда")),
      body: _buildFutureBody(),
    );
  }

  Widget _buildFutureBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ExpandedHorizontally(
          child: CardPadding(
            child: _buildFutureTeamInfo(),
          ),
        ),
        _buildTeamLeadsButton(),
        _buildParticipantsButton(),
      ],
    );
  }

  FutureWidgetBuilder<Team> _buildFutureTeamInfo() {
    return FutureWidgetBuilder(
      TeamRepo.I.get(widget.id),
      _buildTeamInfo,
    );
  }

  Widget _buildTeamInfo(context, Team team) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TeamInfo(team: team),
      ],
    );
  }

  Widget _buildTeamLeadsButton() {
    return ExpandedHorizontally(
      child: CardPadding(
        child: Text("Тренеры"),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return TeamLeadsScreen(teamId: widget.id);
          }));
        },
      ),
    );
  }

  _buildParticipantsButton() {
    return ExpandedHorizontally(
      child: CardPadding(
        child: Text("Участники"),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return TeamParticipantsScreen(
              teamId: widget.id,
              onUpdate: _onUpdate,
            );
          }));
        },
      ),
    );
  }

  void _onUpdate() {
    widget.onUpdate();
    setState(() {});
  }
}
