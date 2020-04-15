import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/layout/shrunk_vertically.dart';
import 'package:gtoserviceapp/components/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/navigation/tabs.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/screens/profile/profile.dart';
import 'package:gtoserviceapp/services/auth/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;

  _updatePassword(String password) {
    setState(() {
      _password = password;
    });
  }

  _updateEmail(String email) {
    setState(() {
      _email = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Вход"),
          automaticallyImplyLeading: false,
        ),
        body: _buildBody(context),
        bottomNavigationBar: NavigationBar(Tabs.Profile),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ShrunkVertically(
      child: CardPadding(
        child: Column(
          children: <Widget>[
            _buildEmailField(),
            _buildPasswordField(),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() => TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Email",
          prefixIcon: Icon(Icons.email),
        ),
        onChanged: _updateEmail,
      );

  Widget _buildPasswordField() => TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Пароль",
          prefixIcon: Icon(Icons.vpn_key),
        ),
        onChanged: _updatePassword,
//        onFieldSubmitted: (value) => {_password = value},
      );

  Widget _buildButton(context) => RaisedButton(
        child: Text("Войти"),
        onPressed: _onButtonPressed(context),
        disabledColor: Colors.grey.shade400,
        disabledTextColor: Colors.black,
      );

  Function() _onButtonPressed(context) {
    const passwordMinLen = 6;
    if (_email == null ||
        _email.isEmpty ||
        _password == null ||
        _password.length < passwordMinLen) {
      return null;
    }

    return () => Auth.I
        .login(_email, _password)
        .then((_) => _onSuccess(context))
        .catchError((error) => _onError(context, error));
  }

  _onSuccess(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) {
          return ProfileScreen();
        },
      ),
    );
  }

  _onError(BuildContext context, error) {
    showDialog(context: context, child: ErrorDialog.fromError(error));
  }
}
