import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/navigation/tabs.dart';
import 'package:gtoserviceapp/screens/profile/profile.dart';
import 'package:gtoserviceapp/services/auth/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Вход"),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: <Widget>[
            _buildEmailField(),
            _buildPasswordField(),
            _buildButton(context),
          ],
        ),
        bottomNavigationBar: NavigationBar(Tabs.Profile),
      ),
    );
  }

  Widget _buildEmailField() => TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Email",
          prefixIcon: Icon(Icons.email),
        ),
        onChanged: (value) => {_email = value},
      );

  Widget _buildPasswordField() => TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Пароль",
          prefixIcon: Icon(Icons.vpn_key),
        ),
        onChanged: (value) => {_password = value},
      );

  Widget _buildButton(context) => RaisedButton(
        child: Text("Войти"),
        onPressed: () => _onButtonPressed(context),
        disabledColor: Colors.grey.shade400,
        disabledTextColor: Colors.black,
      );

  _onButtonPressed(context) {
    Auth.I
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

  _onError(context, error) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text("Ошибка"),
        content: Text(error.toString()),
      ),
    );
  }
}
