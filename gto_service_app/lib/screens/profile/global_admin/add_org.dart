import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/models.dart';

class AddOrgScreen extends StatefulWidget {
  @override
  _AddOrgScreenState createState() => _AddOrgScreenState();
}

class _AddOrgScreenState extends State<AddOrgScreen> {
  final _formKey = GlobalKey<FormState>();
  final _org = Organisation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Создание организации")),
      body: _buildForm(),
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
        child: Text("Создать"),
        onPressed: () async {
          var form = _formKey.currentState;

          if (form.validate()) {
            form.save();

            var result = API.I.createOrg(_org);
            ErrorDialog.showOnFutureError(context, result);
            await result;

            Navigator.of(context).pop();
          }
        });
  }

  TextFormField _buildNameField() {
    return TextFormField(
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
      decoration: InputDecoration(
        labelText: "Лицевой счет",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Введите лицевой счет";
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
      decoration: InputDecoration(
        labelText: "Расчётный счет",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Введите расчётный счет";
        }
        return null;
      },
      onSaved: (value) {
        _org.correspondentAccount = value;
      },
    );
  }
}
