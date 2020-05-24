import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/card_list_view.dart';
import 'package:gtoserviceapp/components/widgets/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/widgets/dialogs/yes_no_dialog.dart';
import 'package:gtoserviceapp/components/widgets/future_widget_builder.dart';
import 'package:gtoserviceapp/services/utils/utils.dart';

class CatalogScreen<T> extends StatefulWidget {
  final String _title;
  final Future<List<T>> Function() _getData;
  final Widget Function(T) _buildInfo;
  final void Function(BuildContext) _onFabPressed;
  final Future Function(T) _onDeletePressed;
  final void Function(T) _onEditPressed;
  final void Function(BuildContext, T) _onTapped;

  CatalogScreen({
    @required String title,
    @required Future<List<T>> Function() getData,
    @required Widget Function(T) buildInfo,
    Function(BuildContext) onFabPressed,
    Future Function(T) onDeletePressed,
    Function(T) onEditPressed,
    void Function(BuildContext, T) onTapped,
  })  : _title = title,
        _getData = getData,
        _buildInfo = buildInfo,
        _onFabPressed = onFabPressed,
        _onDeletePressed = onDeletePressed,
        _onEditPressed = onEditPressed,
        _onTapped = onTapped;

  @override
  _CatalogScreenState<T> createState() => _CatalogScreenState<T>();
}

class _CatalogScreenState<T> extends State<CatalogScreen<T>> {
  @override
  Widget build(BuildContext context) {
    return Utils.tryCatchLog(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget._title),
        ),
        body: _buildBody(),
        floatingActionButton:
            widget._onFabPressed != null ? _buildFab(context) : null,
      );
    });
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
      widget._getData(),
      (context, List<T> data) => _buildList(data),
    );
  }

  Widget _buildList(List<T> data) {
    return CardListView<T>(
      data,
      _buildElement,
      onTap: widget._onTapped,
    );
  }

  Widget _buildElement(_, T data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: widget._buildInfo(data)),
        widget._onEditPressed != null ? _buildEditButton(data) : Container(),
        widget._onDeletePressed != null
            ? _buildDeleteButton(data)
            : Container(),
      ],
    );
  }

  Widget _buildEditButton(T data) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => widget._onEditPressed(data),
    );
  }

  IconButton _buildDeleteButton(T data) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        showDialog(
          context: context,
          child: YesNoDialog(
            "Вы уверены?",
            _onDeletePressed(data),
          ),
        );
      },
    );
  }

  void Function() _onDeletePressed(T data) {
    return () {
      widget
          ._onDeletePressed(data)
          .then((_) => setState(() {}))
          .catchError((error) {
        showDialog(context: context, child: ErrorDialog.fromError(error));
      });
    };
  }

  Widget _buildFab(context) {
    return FloatingActionButton(
      onPressed: () => widget._onFabPressed.call(context),
      child: Icon(Icons.add),
    );
  }
}
