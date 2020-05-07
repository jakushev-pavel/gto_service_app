import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/forms/text_date_picker.dart';
import 'package:gtoserviceapp/components/future_widget_builder/future_widget_builder.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/models/event.dart';
import 'package:gtoserviceapp/services/repo/event.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class AddEditEventScreen extends StatefulWidget {
  final int _id;

  AddEditEventScreen({int id}) : _id = id;

  @override
  _AddEditEventScreenState createState() => _AddEditEventScreenState();
}

class _AddEditEventScreenState extends State<AddEditEventScreen> {
  final _formKey = GlobalKey<FormState>();
  var _event = Event(
    startDate: DateTime.now(),
    expirationDate: DateTime.now(),
  );

  bool get _isEditing {
    return widget._id != null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("${_isEditing ? "Редактирование" : "Создание"} мероприятия"),
    );
  }

  Widget _buildBody() {
    if (!_isEditing) {
      return _buildForm();
    }

    return _buildFutureForm();
  }

  Widget _buildFutureForm() {
    return FutureWidgetBuilder(
      EventRepo.I.get(Storage.I.read(Keys.organisationId), widget._id),
      (_, Event event) {
        _event = event;
        return _buildForm();
      },
    );
  }

  Widget _buildForm() {
    return CardPadding(
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _buildNameField(),
            _buildDescriptionField(),
            _buildStartDateField(),
            _buildExpirationDateField(),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  TextFormField _buildNameField() {
    return TextFormField(
      initialValue: _event.name,
      decoration: InputDecoration(
        labelText: "Название",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Введите название мероприятия";
        }
        return null;
      },
      onSaved: (value) {
        _event.name = value;
      },
    );
  }

  TextFormField _buildDescriptionField() {
    return TextFormField(
      initialValue: _event.description,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: "Описание",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Введите описание мероприятия";
        }
        return null;
      },
      onSaved: (value) {
        _event.description = value;
      },
    );
  }

  Widget _buildStartDateField() {
    return TextDatePicker(
      (picked) {
        setState(() {
          _event.startDate = picked;
        });
      },
      initialDate: _event.startDate,
      label: "Дата начала",
    );
  }

  Widget _buildExpirationDateField() {
    return TextDatePicker(
      (picked) {
        setState(() {
          _event.expirationDate = picked;
        });
      },
      initialDate: _event.expirationDate,
      label: "Дата завершения",
    );
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      child: Text(_isEditing ? "Сохранить" : "Создать"),
      onPressed: _onSubmitPressed,
    );
  }

  _onSubmitPressed() async {
    var form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }
    form.save();

    var future = _isEditing
        ? EventRepo.I.update(Storage.I.read(Keys.organisationId), _event)
        : EventRepo.I.add(Storage.I.read(Keys.organisationId), _event);
    ErrorDialog.showOnFutureError(context, future);
    await future;

    Navigator.of(context).pop();
  }
}
