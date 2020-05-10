import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/services/repo/sport_object.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class AddSportObjectScreen extends StatefulWidget {
  @override
  _AddSportObjectScreenState createState() => _AddSportObjectScreenState();
}

class _AddSportObjectScreenState extends State<AddSportObjectScreen> {
  final _formKey = GlobalKey<FormState>();
  SportObject _sportObject = SportObject();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(title: Text("Добавление спортивного объекта")),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return CardPadding(
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _buildNameField(),
            _buildAddressField(),
            _buildDescriptionField(),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      child: Text("Добавить"),
      onPressed: _onSubmitPressed,
    );
  }

  TextFormField _buildNameField() {
    return TextFormField(
      initialValue: _sportObject.name,
      decoration: InputDecoration(
        labelText: "Название",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Введите название спортивного объекта";
        }
        return null;
      },
      onSaved: (value) {
        _sportObject.name = value;
      },
    );
  }

  TextFormField _buildAddressField() {
    return TextFormField(
      initialValue: _sportObject.address,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: "Адрес",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Введите адрес спортивного объекта";
        }
        return null;
      },
      onSaved: (value) {
        _sportObject.address = value;
      },
    );
  }

  TextFormField _buildDescriptionField() {
    return TextFormField(
      initialValue: _sportObject.description,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: "Описание",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Введите описание спортивного объекта";
        }
        return null;
      },
      onSaved: (value) {
        _sportObject.description = value;
      },
    );
  }

  _onSubmitPressed() async {
    var form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }
    form.save();

    var future = SportObjectRepo.I.add(
      Storage.I.read(Keys.organisationId),
      _sportObject,
    );
    ErrorDialog.showOnFutureError(context, future);
    await future;

    Navigator.of(context).pop();
  }
}
