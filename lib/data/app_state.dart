import 'package:calimax/data/sp_js_100.dart';
import 'package:calimax/data/sp_js_110.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppState extends Model {
  List<Spjs100> _spjs100;

  List<Spjs110> _spjs110;

  final storage = new FlutterSecureStorage();

  void _fetchMovimientos(int id) async {
    final token = await storage.read(key: 'token');
    final response = await http.post('https://calimaxjs.com/tarjetas',
        body: json.encode({
          'param_in': {'action': 'SL', 'cardNo': id, 'no_meses': 6},
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
    this._spjs110 = responseJson;
    notifyListeners();
  }
}
