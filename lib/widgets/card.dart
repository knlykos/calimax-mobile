import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/sp_js_100.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardList extends StatelessWidget {
  List<Spjs100> data;

  Future<List<Spjs100>> _fetchCards() async {
    final token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIzNSIsImlzc3VlciI6IkNteCIsInN1YmplY3QiOiJubG9wZXpnODdAZ21haWwuY29tIiwiYXVkaWVuY2UiOiJ3IiwiZXhwaXJlc0luIjoiMTJoIiwic2Vzc2lvbiI6Mjc0LCJhbGdvcml0aG0iOiJSUzI1NiIsImlhdCI6MTU1ODQ4NTYyNn0.PYsGCAEIBeQxHQ_wIvgwMsGfQjvna8-UZDnu-WxLrJY';
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
              return CardFrontList();
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
  @override
  Widget build(BuildContext context) {
    return Container(height: 20, width: 50, color: Colors.green[700]);
  }
}
