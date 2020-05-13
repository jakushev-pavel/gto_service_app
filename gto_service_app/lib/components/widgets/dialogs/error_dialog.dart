import 'package:flutter/material.dart';
import 'package:gtoserviceapp/services/utils/utils.dart';

import 'ok_dialog.dart';

class ErrorDialog extends OkDialog {
  static const _title = "Ошибка";

  ErrorDialog.fromText(text) : super(_title, text: text);

  ErrorDialog.fromError(e) : super(_title, text: Utils.errorToString(e));

  static showOnFutureError<T>(BuildContext context, Future<T> future) {
    future.catchError(
      (error) => {
        showDialog(
          context: context,
          child: ErrorDialog.fromError(error),
        )
      },
    );
  }
}
