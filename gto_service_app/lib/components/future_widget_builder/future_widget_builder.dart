import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/failure/failure.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';

class FutureWidgetBuilder<T> extends StatelessWidget {
  final Future<T> _future;
  final Widget Function(BuildContext, T) _builder;
  final Widget Function() _placeholderBuilder;

  FutureWidgetBuilder(this._future, this._builder, {placeholderBuilder})
      : _placeholderBuilder =
            placeholderBuilder ?? (() => _buildDefaultPlaceholder()) {
    _future.catchError((error) {
      print(error.toString());
    });
  }

  static Widget _buildDefaultPlaceholder() {
    return Padding(
      padding: DefaultMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasData) {
          return _builder(context, snapshot.data);
        }
        if (snapshot.hasError) {
          return Failure(snapshot.error);
        }

        return _placeholderBuilder();
      },
    );
  }
}
