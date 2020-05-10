import 'package:flutter/material.dart';
import 'package:gtoserviceapp/services/utils/utils.dart';

class Failure extends StatelessWidget {
  final _error;

  Failure(this._error) {
    print(this._error);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.error, color: Colors.red),
        SizedBox(width: 8),
        Flexible(
          child: Text(
            Utils.errorToString(_error),
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
      ],
    );
  }
}
