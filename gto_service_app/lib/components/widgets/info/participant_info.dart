import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/widgets/text/caption.dart';
import 'package:gtoserviceapp/models/role.dart';
import 'package:gtoserviceapp/services/repo/participant.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';
import 'package:gtoserviceapp/services/utils/utils.dart';

class ParticipantInfo extends StatelessWidget {
  final Participant participant;
  final void Function() onUpdate;
  final bool editable;

  ParticipantInfo({
    @required this.participant,
    @required this.onUpdate,
    bool editable,
  }) : editable = editable ?? true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(participant.name +
                " (#" +
                participant.eventParticipantId.toString() +
                ")"),
            CaptionText(participant.email),
            CaptionText(Utils.formatDate(participant.dateOfBirth)),
            participant.isConfirmed
                ? Container()
                : CaptionText("Не подтвержден", color: Colors.red),
          ],
        ),
        _buildConfirmButton(context),
      ],
    );
  }

  _buildConfirmButton(context) {
    bool canConfirm = editable &&
        (Storage.I.role == Role.LocalAdmin || Storage.I.role == Role.Secretary);
    if (!canConfirm || participant.isConfirmed) {
      return Container();
    }

    return IconButton(
      icon: Icon(Icons.check),
      onPressed: () => _onConfirmPressed(context),
    );
  }

  void _onConfirmPressed(context) {
    ParticipantRepo.I
        .confirm(
      participant.eventParticipantId,
    )
        .then((_) {
      onUpdate();
    }).catchError((error) {
      showDialog(context: context, child: ErrorDialog.fromError(error));
    });
  }
}