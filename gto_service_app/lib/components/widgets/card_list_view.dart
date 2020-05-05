import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/text/headline.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';

class CardListView<T> extends StatelessWidget {
  final List<T> _data;
  final Widget Function(BuildContext, T) _builder;
  final Function(BuildContext, T) _onTap;

  CardListView(this._data, this._builder, {Function(BuildContext, T) onTap})
      : _onTap = onTap ?? ((_, __) => {});

  @override
  Widget build(BuildContext context) {
    if (_data.length == 0) {
      return Padding(
        padding: DefaultMargin,
        child: HeadlineText("Список пуст"),
      );
    }

    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        SizedBox(height: 14),
        ..._data.map((T data) => _buildTile(context, data)).toList(),
        SizedBox(height: 14),
      ],
    );
  }

  Widget _buildTile(context, T data) {
    return CardPadding(
      margin: ListMargin,
      onTap: () => _onTap(context, data),
      child: InkWell(
        child: _builder(context, data),
      ),
    );
  }
}