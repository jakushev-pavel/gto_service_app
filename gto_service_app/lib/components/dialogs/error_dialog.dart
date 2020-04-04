import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/dialogs/ok_dialog.dart';
import 'package:gtoserviceapp/services/api/api_error.dart';

class ErrorDialog extends OkDialog {
  static const _title = "Ошибка";

  ErrorDialog.fromText(text) : super(_title, text: text);

  static _errorToText(Exception e) {
    if (e is APIErrors) {
      return e.toText();
    }

    return e.toString();
  }

  ErrorDialog.fromError(e) : super(_title, text: _errorToText(e));

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
