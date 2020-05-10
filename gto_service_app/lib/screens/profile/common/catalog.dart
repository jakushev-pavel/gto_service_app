import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/card_list_view.dart';
import 'package:gtoserviceapp/components/widgets/future_widget_builder.dart';

class CatalogScreen<T> extends StatelessWidget {
  final String _title;
  final Future<List<T>> Function() _getData;
  final Widget Function(T) _buildInfo;
  final Function(BuildContext) _onFabPressed;
  final Function(T) _onDeletePressed;
  final Function(T) _onEditPressed;

  CatalogScreen({
    @required String title,
    @required Future<List<T>> Function() getData,
    @required Widget Function(T) buildInfo,
    @required Function(BuildContext) onFabPressed,
    @required Function(T) onDeletePressed,
    Function(T) onEditPressed,
  })  : _title = title,
        _getData = getData,
        _buildInfo = buildInfo,
        _onFabPressed = onFabPressed,
        _onDeletePressed = onDeletePressed,
        _onEditPressed = onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: _buildBody(),
      floatingActionButton: _buildFab(context),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _buildFutureList(),
      ],
    );
  }

  FutureWidgetBuilder<List<T>> _buildFutureList() {
    return FutureWidgetBuilder(
      _getData(),
      (context, List<T> data) => _buildList(data),
    );
  }

  Widget _buildList(List<T> data) {
    return CardListView(data, _buildElement);
  }

  Widget _buildElement(_, T data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: _buildInfo(data)),
        _onEditPressed != null ? _buildEditButton(data) : Container(),
        _buildDeleteButton(data),
      ],
    );
  }

  Widget _buildEditButton(T data) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => _onEditPressed(data),
    );
  }

  IconButton _buildDeleteButton(T data) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () => _onDeletePressed(data),
    );
  }

  Widget _buildFab(context) {
    return FloatingActionButton(
      onPressed: () => _onFabPressed(context),
      child: Icon(Icons.add),
    );
  }
}
