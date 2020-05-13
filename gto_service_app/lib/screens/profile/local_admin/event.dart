import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/card_list_view.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/components/widgets/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/widgets/dialogs/yes_no_dialog.dart';
import 'package:gtoserviceapp/components/widgets/expanded_horizontally.dart';
import 'package:gtoserviceapp/components/widgets/field.dart';
import 'package:gtoserviceapp/components/widgets/future_widget_builder.dart';
import 'package:gtoserviceapp/components/widgets/text/caption.dart';
import 'package:gtoserviceapp/components/widgets/text/date.dart';
import 'package:gtoserviceapp/components/widgets/text/headline.dart';
import 'package:gtoserviceapp/models/event.dart';
import 'package:gtoserviceapp/screens/profile/local_admin/add_edit_event.dart';
import 'package:gtoserviceapp/services/repo/event.dart';
import 'package:gtoserviceapp/services/repo/secretary.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class EventScreen extends StatelessWidget {
  final int _id;

  EventScreen(this._id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _onAddSecretaryPressed(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildFutureEventCard(context),
        _buildSecretaryListHeader(),
        _buildFutureSecretaryList(),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Мероприятие"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => _onEditPressed(context),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _onDeletePressed(context),
        ),
      ],
    );
  }

  Widget _buildFutureEventCard(context) {
    return FutureWidgetBuilder(
      EventRepo.I.get(Storage.I.read(Keys.organisationId), _id),
      _buildEventCard,
    );
  }

  Widget _buildEventCard(context, Event event) {
    return ExpandedHorizontally(
      child: CardPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeadlineText(event.name),
            Text(event.description),
            Row(
              children: <Widget>[
                Field("Начало", child: DateText(event.startDate)),
                SizedBox(width: 16),
                Field("Конец", child: DateText(event.expirationDate)),
              ],
            ),
            Field("Статус", child: Text(event.status)),
          ],
        ),
      ),
    );
  }

  _onEditPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return AddEditEventScreen(id: _id);
    }));
  }

  _onDeletePressed(context) {
    showDialog(
        context: context,
        child: YesNoDialog("Удалить мероприятие?", () async {
          var future =
              EventRepo.I.delete(Storage.I.read(Keys.organisationId), _id);
          ErrorDialog.showOnFutureError(context, future);
          await future;

          Navigator.of(context).pop();
        }));
  }

  Widget _buildSecretaryListHeader() {
    return Padding(
      padding: DefaultMargin,
      child: HeadlineText("Секретари:"),
    );
  }

  Widget _buildFutureSecretaryList() {
    return FutureWidgetBuilder(
      SecretaryRepo.I.getFromEvent(Storage.I.read(Keys.organisationId), _id),
      (context, List<Secretary> data) => _buildSecretaryList(data),
    );
  }

  Widget _buildSecretaryList(List<Secretary> list) {
    return CardListView(list, _buildSecretary);
  }

  Widget _buildSecretary(_, Secretary secretary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(secretary.name),
        CaptionText(secretary.email),
      ],
    );
  }

  _onAddSecretaryPressed(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//      return AddSecretaryScreen();
    }));
  }
}
