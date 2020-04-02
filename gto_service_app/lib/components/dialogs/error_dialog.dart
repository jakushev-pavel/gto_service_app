import 'package:flutter/material.dart';
import 'package:gtoserviceapp/services/api/api_error.dart';

class ErrorDialog extends StatelessWidget {
  final String _text;

  ErrorDialog.fromText(this._text);

  static _errorToText(Exception e) {
    if (e is APIErrors) {
      return e.toText();
    }

    return e.toString();
  }

  ErrorDialog.fromError(e) : _text = _errorToText(e);

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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Ошибка"),
      content: _text == null ? null : Text(_text),
      actions: <Widget>[
        FlatButton(
          child: Text("Ok"),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}
