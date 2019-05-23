import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/sp_js_100.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:mobile/widgets/card.dart';

final storage = new FlutterSecureStorage();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  List<Spjs100> data;

  Future<List<Spjs100>> _fetchCards() async {
    final token = await storage.read(key: 'token');
    final response = await http.post('https://calimaxjs.com/tarjetas',
        body: json.encode({
          "param_in": {'action': 'SL'},
          'param_out': {},
          'funcion': 'sp_js_100'
        }),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    var responseJson = (json.decode(response.body) as List)
        .map((e) => Spjs100.fromJson(e))
        .toList();

    return responseJson;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.tags_solid),
            title: Text('Tarjetas'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.eye_solid),
            title: Text('Detalles'),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle:
                    (index == 0) ? Text('Tarjetas Calimax') : Text('Detalles'),
              ),
              child: CardList(),
            );
          },
        );
      },
    );
  }

  Widget _list() {
    return FutureBuilder(
      future: _fetchCards(),
      initialData: this.data,
      builder: (BuildContext context, AsyncSnapshot<List<Spjs100>> snapshop) {
        if (snapshop.connectionState == ConnectionState.done) {
          return ListView(
            children: _listaItems(snapshop.data),
          );
        } else {
          return Text('Hola');
        }
      },
    );
  }

  List<Widget> _listaItems(List<Spjs100> data) {
    final List<Widget> opciones = [];

    data.forEach((opt) {
      print(opt.descTarjeta);
      print(opt.sdoMonedero);
      final widgetTemp = SafeArea(
        top: false,
        bottom: false,
        minimum: EdgeInsets.only(
          left: 16,
          top: 8,
          bottom: 8,
          right: 8,
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 20,
              width: 50,
              color: Colors.red,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100.0))),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(opt.descTarjeta),
                    opt.descTarjeta != 'Tarjeta de Monedero'
                        ? Text('\$' + opt.sdoVales.toString())
                        : Text('\$' + opt.sdoMonedero.toString()),
                  ],
                ),
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(
                CupertinoIcons.plus_circled,
                semanticLabel: 'Add',
              ),
              onPressed: () {
                print('Se apreto el boton');
              },
            )
          ],
        ),
      );

      opciones..add(widgetTemp);
    });

    // return Column(children: <Widget>[

    // ],);
    return opciones;
  }
}

class DetailScreen extends StatelessWidget {
  DetailScreen(this.topic);
  final String topic;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Details'),
      ),
      child: Center(
        child: Text(
          'Details for $topic',
          style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
        ),
      ),
    );
  }
}
