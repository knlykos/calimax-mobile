import 'package:flutter/cupertino.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();

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
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Calimax',
              style: TextStyle(fontSize: 30),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: CupertinoTextField(
                focusNode: _focusNodeEmail,
                prefix: Icon(
                  CupertinoIcons.mail,
                  color: _getInputStyleColorEmail(),
                  size: 28.0,
                ),
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
                clearButtonMode: OverlayVisibilityMode.editing,
                textCapitalization: TextCapitalization.words,
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
                focusNode: _focusNodePassword,
                prefix: Icon(
                  CupertinoIcons.padlock,
                  color: _getInputStyleColorPassword(),
                  size: 28.0,
                ),
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
                clearButtonMode: OverlayVisibilityMode.editing,
                textCapitalization: TextCapitalization.words,
                autocorrect: false,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 0.0, color: _getInputStyleColorPassword())),
                ),
                placeholder: 'Contraseña',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: CupertinoButton.filled(
                child: Text('Iniciar Sesión'),
                onPressed: () {
                  print('Iniciar');
                },
              ),
            )
          ],
        ),
      ),
      // navigationBar: CupertinoNavigationBar(
      //   middle: Text('Hola'),
      // ),
    );
  }
}
