import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/sp_js_100.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardList extends StatelessWidget {
  List<Color> colors = [
    Color(int.parse('0xFF11C26D')),
    Color(int.parse('0xFFF99D0A')),
    Color(int.parse('0xFFF02A05')),
    Color(int.parse('0xFF056BBA')),
  ];
  List<Spjs100> data;

  Future<List<Spjs100>> _fetchCards() async {
    final token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIzNSIsImlzc3VlciI6IkNteCIsInN1YmplY3QiOiJubG9wZXpnODdAZ21haWwuY29tIiwiYXVkaWVuY2UiOiJ3IiwiZXhwaXJlc0luIjoiMTJoIiwic2Vzc2lvbiI6Mjc1LCJhbGdvcml0aG0iOiJSUzI1NiIsImlhdCI6MTU1ODUxMzg4MH0.7LlLJf77qymhHUCxh2M1xplQUvT7Fpgixn87xq8W2sc';
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
                      bottom: 40,
                      left: 30,
                      child: Text(
                        snapshop.data[index].cuentaR,
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 30,
                      child: snapshop.data[index].descTarjeta !=
                              'Tarjeta de Monedero'
                          ? Text(
                              '\$' + snapshop.data[index].sdoVales.toString())
                          : Text('\$' +
                              snapshop.data[index].sdoMonedero.toString()),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 30,
                      child: Text(
                        snapshop.data[index].nombre +
                            ' ' +
                            snapshop.data[index].apellidoP +
                            ' ' +
                            snapshop.data[index].apellidoP,
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
            itemWidth: _screenSize.width * 0.7,
            itemHeight: _screenSize.height * 0.25,
            layout: SwiperLayout.STACK,
          );
        } else {
          return Text('Hola');
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
