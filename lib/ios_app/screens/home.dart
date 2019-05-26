import 'package:calimax/data/app_state.dart';
import 'package:flutter/cupertino.dart';

import 'package:calimax/models/sp_js_100.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:calimax/data/sp_js_110.dart';
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:calimax/widgets/card.dart';
import 'package:scoped_model/scoped_model.dart';

final storage = new FlutterSecureStorage();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  List<Spjs100> data;
  List<Spjs110> movimientos;

  Future<List<Spjs110>> _fetchMovimientos() async {
    final token = await storage.read(key: 'token');
    final response = await http.post('https://calimaxjs.com/tarjetas',
        body: json.encode({
          'param_in': {'action': 'SL', 'cardNo': '258', 'no_meses': 6},
          'param_out': {},
          'funcion': 'sp_js_110'
        }),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    var responseJson = (json.decode(response.body) as List)
        .map((e) => Spjs110.fromJson(e))
        .toList();
    return responseJson;
  }

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
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      // tabBar: CupertinoTabBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(CupertinoIcons.tags_solid),
      //       title: Text('Tarjetas'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(CupertinoIcons.eye_solid),
      //       title: Text('Detalles'),
      //     ),
      //   ],
      // ),
      // tabBuilder: (context, index) {
      //   return CupertinoTabView(
      //     builder: (context) {
      //       return CupertinoPageScaffold(
      //         navigationBar: CupertinoNavigationBar(
      //           middle:
      //               (index == 0) ? Text('Tarjetas Calimax') : Text('Detalles'),
      //         ),
      //         child: CardList(),
      //       );
      //     },
      //   );
      // },
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: true,
        middle: Text('Calimax'),
        automaticallyImplyLeading: false,
      ),
      child: Container(
        margin: EdgeInsets.only(top: 68),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: CardList(),
            ),
            Expanded(
              child: _movList(),
            ),
          ],
        ),
      ),
    );
  }

  final List<Widget> opciones = [];
  Widget _movList() {
    return ScopedModelDescendant<AppState>(
      builder: (context, child, model) => CupertinoScrollbar(
            child: ListView.builder(
              itemCount: model.movimientos.length,
              // children: _listaItems(model.movimientos),
              itemBuilder: (context, index) {
                if (model.movimientos.length == 0) {
                  return CupertinoActivityIndicator();
                } else {
                  return _listaItems(model.movimientos[index]);
                }
                // return CupertinoScrollbar(
                //   child: ListView(
                //     children: _listaItems(model.movimientos),
                //   ),
                // );
              },
            ),
          ),
    );
    // return FutureBuilder(
    //   future: _fetchMovimientos(),
    //   initialData: this.movimientos,
    //   builder: (BuildContext context, AsyncSnapshot<List<Spjs110>> snapshop) {
    //     if (snapshop.connectionState == ConnectionState.done) {
    //       return ScopedModel<AppState>(
    //         model: AppState(),
    //         child: ScopedModelDescendant<AppState>(
    //           builder: (context, child, model) => CupertinoScrollbar(
    //                 child: ListView(
    //                   children: _listaItems(model.Movimientos),
    //                 ),
    //               ),
    //         ),
    //       );
    //     } else {
    //       return CupertinoActivityIndicator();
    //     }
    //   },
    // );
  }

  // Widget _list() {
  //   return FutureBuilder(
  //     future: _fetchCards(),
  //     initialData: this.data,
  //     builder: (BuildContext context, AsyncSnapshot<List<Spjs100>> snapshop) {
  //       if (snapshop.connectionState == ConnectionState.done) {
  //         return ListView(
  //           children: _listaItems(snapshop.data),
  //         );
  //       } else {
  //         return Center(
  //           child: CupertinoActivityIndicator(),
  //         );
  //       }
  //     },
  //   );
  // }

  final formatted = new DateFormat('yyyy-MM-dd');
  Widget _listaItems(Spjs110 data) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        boxShadow: [],
      ),
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10, right: 10),
      height: 40,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            child: Icon(
              data.importe > 0
                  ? CupertinoIcons.up_arrow
                  : CupertinoIcons.down_arrow,
              color: data.importe > 0
                  ? CupertinoColors.activeGreen
                  : CupertinoColors.destructiveRed,
            ),
          ),
          Positioned(
            left: 30,
            child: Text(data.descripcion),
          ),
          Positioned(
            left: 30,
            bottom: 0,
            child: Text(
              formatted.format(data.fecha),
              style: TextStyle(fontSize: 14),
            ),
          ),
          Positioned(
            right: 0,
            child: Text(
              '\$' + data.saldo.toString(),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Text(
              '\$' + data.importe.toString(),
              style: TextStyle(
                  fontSize: 14,
                  color: data.importe > 0
                      ? CupertinoColors.activeGreen
                      : CupertinoColors.destructiveRed),
            ),
          ),
        ],
      ),
    );
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
