import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/components/widgets/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/services/repo/team.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class AddTeamScreen extends StatefulWidget {
  final int eventId;
  final Function() onUpdate;

  AddTeamScreen({
    @required this.eventId,
    @required this.onUpdate,
  });

  @override
  _AddTeamScreenState createState() => _AddTeamScreenState();
}

class _AddTeamScreenState extends State<AddTeamScreen> {
  final _key = GlobalKey<FormState>();
  String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Создание команды")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Form(
      key: _key,
      child: CardPadding(
        child: Column(
          children: <Widget>[
            _buildNameField(),
            SizedBox(height: 16),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  TextFormField _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Название команды",
      ),
      autofocus: true,
      onSaved: (String name) {
        _name = name;
      },
      validator: (String name) {
        if (name.isEmpty) {
          return "Введите название команды";
        }
        return null;
      },
    );
  }

  RaisedButton _buildSubmitButton() {
    return RaisedButton(
      child: Text("Создать"),
      onPressed: _onSubmitPressed,
    );
  }

  void _onSubmitPressed() {
    var form = _key.currentState;
    if (!form.validate()) {
      return;
    }
    form.save();

    TeamRepo.I.addToEvent(Storage.I.orgId, widget.eventId, _name).then((_) {
      widget.onUpdate();
      Navigator.of(context).pop();
    }).catchError((error) {
      showDialog(context: context, child: ErrorDialog.fromError(error));
    });
  }
}
