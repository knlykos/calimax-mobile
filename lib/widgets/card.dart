import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calimax/models/sp_js_100.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

class CardList extends StatelessWidget {
  List<Color> colors = [
    Color(int.parse('0xFF0159AA')),
    Color(int.parse('0xFF1287B5')),
    Color(int.parse('0xFF281E55')),
    Color(int.parse('0xFF60C4AF')),
  ];
  Spjs100 spjs100 = Spjs100();
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
    final _screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _fetchCards(),
      initialData: this.data,
      builder: (BuildContext context, AsyncSnapshot<List<Spjs100>> snapshop) {
        if (snapshop.connectionState == ConnectionState.done) {
          return Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 10,
                      left: 15,
                      child: Image.asset(
                        'assets/images/logo-calimax.png',
                        height: 30.0,
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 28,
                      child: Text(
                        spjs100.obscureCuentaR(snapshop.data[index].cuentaR),
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 3,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 28,
                      child: snapshop.data[index].descTarjeta !=
                              'Tarjeta de Monedero'
                          ? Text(
                              '\$' + snapshop.data[index].sdoVales.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            )
                          : Text(
                              '\$' +
                                  snapshop.data[index].sdoMonedero.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 23,
                      child: Text(
                        snapshop.data[index].descTarjeta,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 23,
                      child: Text(
                        snapshop.data[index].nombre +
                            ' ' +
                            snapshop.data[index].apellidoP +
                            ' ' +
                            snapshop.data[index].apellidoM,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                height: 20,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: colors[index]),
              );
            },
            itemCount: 3,
            itemWidth: 300,
            itemHeight: 185,
            layout: SwiperLayout.TINDER,
            onIndexChanged: (int i) {
              print(snapshop.data[i].id);
            },
          );
        } else {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}

class CardFrontList extends StatelessWidget {
  CardFrontList({List<Spjs100> data});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.green),
    );
  }
}
