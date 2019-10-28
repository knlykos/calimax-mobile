import 'dart:convert';

import 'package:mobile/models/rutas.dart';

class Usuario {
  String idUsu;
  String usuario;
  String email;
  int estado;
  List ruta;
  String permisos;
  int statuscode;
  int codigo;
  String mensaje;
  String token;

  Usuario(
      {this.idUsu,
      this.usuario,
      this.email,
      this.estado,
      this.ruta,
      this.permisos,
      this.statuscode,
      this.codigo,
      this.mensaje,
      this.token});

  Usuario.fromJson(Map<String, dynamic> jsonMap) {
    idUsu = jsonMap['id_usu'];
    usuario = jsonMap['usuario'];
    email = jsonMap['email'];
    estado = jsonMap['estado'];
    ruta = new List.from(jsonMap['ruta']);
    permisos = jsonMap['permisos'];
    statuscode = jsonMap['statuscode'];
    codigo = jsonMap['codigo'];
    mensaje = jsonMap['mensaje'];
    token = jsonMap['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_usu'] = this.idUsu;
    data['usuario'] = this.usuario;
    data['email'] = this.email;
    data['estado'] = this.estado;
    data['ruta'] = this.ruta;
    data['permisos'] = this.permisos;
    data['statuscode'] = this.statuscode;
    data['codigo'] = this.codigo;
    data['mensaje'] = this.mensaje;
    data['token'] = this.token;
    return data;
  }
}
