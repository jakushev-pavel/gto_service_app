import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gtoserviceapp/services/api/api_error.dart';

class Failure extends StatelessWidget {
  final _error;

  Failure(this._error);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.error, color: Colors.red),
        SizedBox(width: 8),
        Flexible(
            child: Text(
          _buildText(),
          style: TextStyle(color: Colors.deepOrange),
        )),
      ],
    );
  }

  String _buildText() {
    if (!kReleaseMode) {
      // Debug
      return _error.toString();
    }

    if (_error is APIErrors) {
      return (_error as APIErrors).toText();
    } else if (_error is SocketException) {
      return "Не удалось подключиться к серверу";
    } else {
      return _error.toString();
    }
  }
}
