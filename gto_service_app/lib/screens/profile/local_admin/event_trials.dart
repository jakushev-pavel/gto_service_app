import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/future_widget_builder.dart';
import 'package:gtoserviceapp/components/widgets/text/caption.dart';
import 'package:gtoserviceapp/components/widgets/text/headline.dart';
import 'package:gtoserviceapp/screens/common/catalog.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_event_trial.dart';
import 'package:gtoserviceapp/services/repo/referee.dart';
import 'package:gtoserviceapp/services/repo/sport_object.dart';
import 'package:gtoserviceapp/services/repo/trial.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';
import 'package:gtoserviceapp/services/utils/utils.dart';

class EventTrialsCatalogScreen extends StatefulWidget {
  final int eventId;

  EventTrialsCatalogScreen({@required this.eventId});

  @override
  _EventTrialsCatalogScreenState createState() =>
      _EventTrialsCatalogScreenState();
}

class _EventTrialsCatalogScreenState extends State<EventTrialsCatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return CatalogScreen<EventTrial>(
      title: "Виды спорта",
      getData: () => TrialRepo.I.getFromEvent(widget.eventId),
      buildInfo: _buildInfo,
      onFabPressed: _onFabPressed,
      onDeletePressed: _onDeletePressed,
    );
  }

  Widget _buildInfo(EventTrial trial) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeadlineText(trial.name),
        Row(
          children: <Widget>[
            CaptionText(Utils.formatDateTime(trial.startDateTime)),
            SizedBox(width: 16),
            _buildSportObjectInfo(trial.sportObjectId),
          ],
        ),
        _buildRefereesInfo(trial.referees),
      ],
    );
  }

  Widget _buildSportObjectInfo(int sportObjectId) {
    return FutureWidgetBuilder(
      SportObjectRepo.I.getAll(Storage.I.orgId),
      (context, List<SportObject> list) {
        return CaptionText(
          list
              .where((sportObject) => sportObject.id == sportObjectId)
              .first
              .name,
        );
      },
    );
  }

  _onFabPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return AddEventTrialScreen(
        eventId: widget.eventId,
        onUpdate: _onUpdate,
      );
    }));
  }

  Future<void> _onDeletePressed(EventTrial eventTrial) {
    return TrialRepo.I.deleteFromEvent(eventTrial.trialInEventId);
  }

  _buildRefereesInfo(List<Referee> referees) {
    if (referees.isEmpty) {
      return CaptionText("Судьи не назначены");
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CaptionText("Судьи: "),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              referees.map((referee) => CaptionText(referee.name)).toList(),
        ),
      ],
    );
  }

  void _onUpdate() {
    setState(() {});
  }
}
