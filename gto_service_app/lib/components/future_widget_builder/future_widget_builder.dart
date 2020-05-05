import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/failure/failure.dart';

class FutureWidgetBuilder<T> extends StatelessWidget {
  final Future<T> _future;
  final Widget Function(BuildContext, T) _builder;
  final Widget Function() _placeholderBuilder;

  FutureWidgetBuilder(this._future, this._builder, {placeholderBuilder})
      : _placeholderBuilder =
            placeholderBuilder ?? (() => CircularProgressIndicator()) {
    _future.catchError((error) {
      print(error.toString());
    });
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
