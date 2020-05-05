import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/text/headline.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';

class CardListView<T> extends StatelessWidget {
  final List<T> _data;
  final Widget Function(T) _builder;

  CardListView(this._data, this._builder);

  @override
  Widget build(BuildContext context) {
    if (_data.length == 0) {
      return Padding(
        padding: DefaultMargin,
        child: HeadlineText("Список пуст"),
      );
    }

    return ListView(
      children: <Widget>[
        SizedBox(height: 14),
        ..._data.map(_buildTile).toList(),
        SizedBox(height: 14),
      ],
      shrinkWrap: true,
    );
  }

  Widget _buildTile(T data) {
    return CardPadding(
      margin: ListMargin,
      child: _builder(data),
    );
  }
}
