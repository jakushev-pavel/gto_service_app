import 'package:flutter/cupertino.dart';
import 'package:gtoserviceapp/components/text/caption.dart';

class Field extends StatelessWidget {
  final String _caption;
  final Widget _child;

  Field(this._caption, {@required Widget child}) : this._child = child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CaptionText(_caption),
          _child
        ],
      ),
    );
  }
}
