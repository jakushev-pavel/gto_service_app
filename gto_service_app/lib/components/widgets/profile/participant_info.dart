import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/text/caption.dart';
import 'package:gtoserviceapp/services/repo/participant.dart';
import 'package:gtoserviceapp/services/utils/utils.dart';

class ParticipantInfo extends StatelessWidget {
  final Participant participant;

  ParticipantInfo({@required this.participant});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(participant.name +
            " (#" +
            participant.eventParticipantId.toString() +
            ")"),
        CaptionText(participant.email),
        CaptionText(Utils.formatDate(participant.dateOfBirth)),
      ],
    );
  }
}
