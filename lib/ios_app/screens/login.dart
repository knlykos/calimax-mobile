import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calimax/ios_app/screens/home.dart';
import 'package:calimax/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final storage = new FlutterSecureStorage();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();

  final lusernameController = TextEditingController();
  final lpasswordController = TextEditingController();
  final susernameController = TextEditingController();
  final spasswordController = TextEditingController();

  var showProgressIndicator = false;

  Color _getInputStyleColorEmail() {
    return _focusNodeEmail.hasFocus
        ? CupertinoColors.activeGreen
        : CupertinoColors.inactiveGray;
  }

  Color _getInputStyleColorPassword() {
    return _focusNodePassword.hasFocus
        ? CupertinoColors.activeGreen
        : CupertinoColors.inactiveGray;
  }

  void _login() {
    Future<List<Usuario>> fetchPost() async {
      this.showProgressIndicator = true;
      final response = await http.post('https://calimaxjs.com/usuario',
          body: json.encode({
            'param_in': {
              'action': 'LG',
              'email': this.lusernameController.text,
              'password': this.lpasswordController.text
            },
            'param_out': {'gettoken': ''},
            'funcion': 'sp_usuario'
          }),
          headers: {'Content-type': 'application/json'});
      var responseJson = (json.decode(response.body) as List)
          .map((e) => Usuario.fromJson(e))
          .toList();

      print(responseJson[0].codigo);
      if (responseJson[0].codigo == 0) {
        storage.write(key: 'token', value: responseJson[0].token);
        this.showProgressIndicator = false;
        Navigator.pushNamed(context, '/home');
        return responseJson;
      } else {
        print(responseJson[0].codigo);
      }
    }

    fetchPost();
  }

  _onOnFocusNodeEvent() {
    setState(() {
      // Re-renders
    });
  }

  _onOnFocusNodeEventPassword() {
    setState(() {
      // Re-renders
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNodeEmail.addListener(_onOnFocusNodeEvent);
    _focusNodePassword.addListener(_onOnFocusNodeEventPassword);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo-calimax.png',
                  height: 45.0,
                ),
                // Text(
                //   'Calimax',
                //   style: TextStyle(fontSize: 30),
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: CupertinoTextField(
                    controller: lusernameController,
                    focusNode: _focusNodeEmail,
                    prefix: Icon(
                      CupertinoIcons.mail,
                      color: _getInputStyleColorEmail(),
                      size: 28.0,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
                    clearButtonMode: OverlayVisibilityMode.editing,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.0, color: _getInputStyleColorEmail())),
                    ),
                    placeholder: 'Correo Electrónico',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: CupertinoTextField(
                    controller: lpasswordController,
                    focusNode: _focusNodePassword,
                    prefix: Icon(
                      CupertinoIcons.padlock,
                      color: _getInputStyleColorPassword(),
                      size: 28.0,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
                    clearButtonMode: OverlayVisibilityMode.editing,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.0,
                              color: _getInputStyleColorPassword())),
                    ),
                    placeholder: 'Contraseña',
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: CupertinoButton.filled(
                    child: Text('Iniciar Sesión'),
                    onPressed: _login,
                  ),
                )
              ],
            ),
          ),
          showProgressIndicator ? progressIndicator() : Container()
        ],
      ),
      // navigationBar: CupertinoNavigationBar(
      //   middle: Text('Hola'),
      // ),
    );
  }

  Widget progressIndicator() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.3,
          child: ModalBarrier(
            dismissible: false,
            color: Colors.grey,
          ),
        ),
        Center(
          child: CupertinoActivityIndicator(),
        ),
      ],
    );
  }
}
