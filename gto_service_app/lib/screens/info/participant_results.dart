import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/components/widgets/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/widgets/future_widget_builder.dart';
import 'package:gtoserviceapp/components/widgets/text/caption.dart';
import 'package:gtoserviceapp/models/badge.dart';
import 'package:gtoserviceapp/models/role.dart';
import 'package:gtoserviceapp/services/repo/result.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class ParticipantResultsScreen extends StatefulWidget {
  final int eventId;
  final int userId;
  final bool editable;

  ParticipantResultsScreen(
      {@required this.eventId, @required this.userId, bool editable})
      : editable = editable ?? true;

  @override
  _ParticipantResultsScreenState createState() =>
      _ParticipantResultsScreenState();
}

class _ParticipantResultsScreenState extends State<ParticipantResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Результаты")),
      body: _buildFutureBody(),
    );
  }

  Widget _buildFutureBody() {
    return FutureWidgetBuilder<Result>(
      ResultRepo.I.getEventUserResult(widget.eventId, widget.userId),
      _buildBody,
    );
  }

  Widget _buildBody(context, Result result) {
    return ListView(
      children: <Widget>[
        _buildHeader(result),
        ..._buildGroups(result),
      ],
    );
  }

  Widget _buildHeader(Result result) {
    return CardPadding(
      child: Text(result.ageCategory),
    );
  }

  List<Widget> _buildGroups(Result result) {
    return result.groups.map(_buildGroup).expand((i) => i).toList();
  }

  List<Widget> _buildGroup(Group group) {
    return group.trials.map(_buildTrial).toList();
  }

  Widget _buildTrial(Trial trial) {
    return CardPadding(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          trial.badge.toWidget(),
          trial.badge != Badge.Null ? SizedBox(width: 8) : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[Text(trial.trialName), _buildResult(trial)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult(Trial t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildFirstResult(t),
        t.secondResult != null ? _buildSecondResult(t) : Container(),
      ],
    );
  }

  Widget _buildFirstResult(Trial t) {
    bool canEdit = widget.editable &&
        (Storage.I.role == Role.LocalAdmin || Storage.I.role == Role.Secretary);
    if (!canEdit && t.firstResult == null) {
      return Container();
    }

    return Row(
      children: <Widget>[
        CaptionText("Результат: "),
        canEdit ? _buildFirstResultField(t) : Text(t.firstResult.toString())
      ],
    );
  }

  _buildFirstResultField(Trial t) {
    return SizedBox(
      width: 96,
      child: TextFormField(
        initialValue: t.firstResult,
        textAlign: TextAlign.center,
        onFieldSubmitted: (value) => _onFirstResultSubmitted(
          value,
          t.resultInTrialId,
        ),
      ),
    );
  }

  void _onFirstResultSubmitted(String value, int resultId) {
    ResultRepo.I.changeTrialResult(resultId, value).then((_) {
      setState(() {});
    }).catchError((error) {
      showDialog(context: context, child: ErrorDialog.fromError(error));
    });
  }

  Widget _buildSecondResult(Trial t) {
    return Row(
      children: <Widget>[
        CaptionText("Приведенный: "),
        Text(t.secondResult.toString())
      ],
    );
  }
}
