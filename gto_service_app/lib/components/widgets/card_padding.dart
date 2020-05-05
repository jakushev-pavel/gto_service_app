import 'package:flutter/material.dart';

const DefaultMargin = EdgeInsets.fromLTRB(16, 16, 16, 0);
const ListMargin = EdgeInsets.symmetric(vertical: 2, horizontal: 16);

class CardPadding extends StatelessWidget {
  final Widget _child;
  final EdgeInsets _margin;

  CardPadding({
    @required Widget child,
    EdgeInsets margin = DefaultMargin,
  })  : _child = child,
        _margin = margin;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: _margin,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: _child,
      ),
    );
  }
}
