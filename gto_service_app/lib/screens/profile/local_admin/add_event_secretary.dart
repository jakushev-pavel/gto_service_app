import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/components/widgets/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/widgets/future_widget_builder.dart';
import 'package:gtoserviceapp/components/widgets/info/secretary.dart';
import 'package:gtoserviceapp/components/widgets/shrunk_vertically.dart';
import 'package:gtoserviceapp/services/repo/secretary.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class AddEventSecretaryScreen extends StatefulWidget {
  final int _eventId;

  AddEventSecretaryScreen(int eventId) : _eventId = eventId;

  @override
  _AddEventSecretaryScreenState createState() =>
      _AddEventSecretaryScreenState();
}

class _AddEventSecretaryScreenState extends State<AddEventSecretaryScreen> {
  int _selectedId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Добавление секретаря")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ShrunkVertically(
      child: CardPadding(
        child: Column(
          children: <Widget>[
            _buildFutureSelector(),
            SizedBox(height: 16),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildFutureSelector() {
    final String orgId = Storage.I.read(Keys.organisationId);
    return FutureWidgetBuilder(
      SecretaryRepo.I.getFromOrg(orgId),
      (_, List<Secretary> secretaryList) => _buildSelector(secretaryList),
    );
  }

  Widget _buildSelector(List<Secretary> secretaryList) {
    return SizedBox(
      child: DropdownButton(
        isExpanded: true,
        itemHeight: null,
        hint: Text("Выберите секретаря"),
        items: _buildSelectorItems(secretaryList),
        onChanged: _onChanged,
        value: _selectedId,
      ),
    );
  }

  List<DropdownMenuItem<int>> _buildSelectorItems(List<Secretary> list) {
    return list.map((Secretary secretary) {
      return DropdownMenuItem<int>(
        child: SecretaryInfo(secretary),
        value: secretary.secretaryOnOrganizationId,
      );
    }).toList();
  }

  void _onChanged(int id) {
    setState(() {
      _selectedId = id;
    });
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      onPressed: _onSubmitPressed,
      child: Text("Добавить"),
    );
  }

  void _onSubmitPressed() async {
    if (_selectedId == null) {
      return;
    }

    final String orgId = Storage.I.read(Keys.organisationId);
    var future =
        SecretaryRepo.I.addToEvent(orgId, widget._eventId, _selectedId);
    ErrorDialog.showOnFutureError(context, future);
    await future;
    Navigator.of(context).pop();
  }
}
