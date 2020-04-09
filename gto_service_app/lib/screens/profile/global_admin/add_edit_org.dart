import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/models.dart';
import 'package:gtoserviceapp/services/repo/org.dart';

class AddEditOrgScreen extends StatefulWidget {
  final String _orgId;

  AddEditOrgScreen({String orgId}) : _orgId = orgId;

  @override
  _AddEditOrgScreenState createState() => _AddEditOrgScreenState(_orgId);
}

class _AddEditOrgScreenState extends State<AddEditOrgScreen> {
  final _formKey = GlobalKey<FormState>();
  var _org = Organisation();
  String _orgId;

  _AddEditOrgScreenState(this._orgId);

  bool get _isEditing {
    return _orgId != null;
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
      title: Text("${_isEditing ? "Редактирование" : "Создание"} организации"),
    );
  }

  Widget _buildBody() {
    if (!_isEditing) {
      return _buildForm();
    }

    var futureOrg = OrgRepo.I.get(_orgId);
    ErrorDialog.showOnFutureError(context, futureOrg);

    return FutureBuilder(
      future: futureOrg,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _org = snapshot.data;
          return _buildForm();
        }

        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildForm() {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildNameField(),
              _buildAddressField(),
              _buildLeaderField(),
              _buildPhoneNumberField(),
              _buildOqrnField(),
              _buildPaymentAccountField(),
              _buildBranchField(),
              _buildBikField(),
              _buildCorrespondentAccountField(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  RaisedButton _buildSubmitButton() {
    return RaisedButton(
        child: Text(_isEditing ? "Сохранить" : "Создать"),
        onPressed: () async {
          var form = _formKey.currentState;

          if (form.validate()) {
            form.save();

            var result =
                _isEditing ? OrgRepo.I.update(_org) : OrgRepo.I.create(_org);
            ErrorDialog.showOnFutureError(context, result);
            await result;

            Navigator.of(context).pop();
          }
        });
  }

  TextFormField _buildNameField() {
    return TextFormField(
      initialValue: _org.name,
      decoration: InputDecoration(
        labelText: "Название",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Введите название организации";
        }
        return null;
      },
      onSaved: (value) {
        _org.name = value;
      },
    );
  }

  TextFormField _buildAddressField() {
    return TextFormField(
      initialValue: _org.address,
      decoration: InputDecoration(
        labelText: "Адрес",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Введите адрес";
        }
        return null;
      },
      onSaved: (value) {
        _org.address = value;
      },
    );
  }

  TextFormField _buildLeaderField() {
    return TextFormField(
      initialValue: _org.leader,
      decoration: InputDecoration(
        labelText: "Ответственное лицо",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Введите ответственное лицо";
        }
        return null;
      },
      onSaved: (value) {
        _org.leader = value;
      },
    );
  }

  TextFormField _buildPhoneNumberField() {
    return TextFormField(
      initialValue: _org.phoneNumber,
      decoration: InputDecoration(
        labelText: "Номер телефона",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Введите номер телефона";
        }
        return null;
      },
      onSaved: (value) {
        _org.phoneNumber = value;
      },
    );
  }

  TextFormField _buildOqrnField() {
    return TextFormField(
      initialValue: _org.oQRN,
      decoration: InputDecoration(
        labelText: "ОГРН",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Введите ОГРН";
        }
        return null;
      },
      onSaved: (value) {
        _org.oQRN = value;
      },
    );
  }

  TextFormField _buildPaymentAccountField() {
    return TextFormField(
      initialValue: _org.paymentAccount,
      decoration: InputDecoration(
        labelText: "Лицевой счёт",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Введите лицевой счёт";
        }
        return null;
      },
      onSaved: (value) {
        _org.paymentAccount = value;
      },
    );
  }

  TextFormField _buildBranchField() {
    return TextFormField(
      initialValue: _org.branch,
      decoration: InputDecoration(
        labelText: "Филиал",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Введите филиал";
        }
        return null;
      },
      onSaved: (value) {
        _org.branch = value;
      },
    );
  }

  TextFormField _buildBikField() {
    return TextFormField(
      initialValue: _org.bik,
      decoration: InputDecoration(
        labelText: "БИК",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Введите БИК";
        }
        return null;
      },
      onSaved: (value) {
        _org.bik = value;
      },
    );
  }

  TextFormField _buildCorrespondentAccountField() {
    return TextFormField(
      initialValue: _org.correspondentAccount,
      decoration: InputDecoration(
        labelText: "Расчётный счёт",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Введите расчётный счёт";
        }
        return null;
      },
      onSaved: (value) {
        _org.correspondentAccount = value;
      },
    );
  }
}
