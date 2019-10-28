// To parse this JSON data, do
//
//     final rutas = rutasFromJson(jsonString);

import 'dart:convert';

List<Rutas> rutasFromJson(String str) =>
    List<Rutas>.from(json.decode(str).map((x) => Rutas.fromMap(x)));

String rutasToJson(List<Rutas> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Rutas {
  String idUsu;
  String usuario;
  String email;
  int estado;
  String ruta;
  String permisos;
  int idSesion;
  dynamic edoColabora;
  int empresa;
  int multiempresa;
  int statuscode;
  int codigo;
  String mensaje;

  Rutas({
    this.idUsu,
    this.usuario,
    this.email,
    this.estado,
    this.ruta,
    this.permisos,
    this.idSesion,
    this.edoColabora,
    this.empresa,
    this.multiempresa,
    this.statuscode,
    this.codigo,
    this.mensaje,
  });

  factory Rutas.fromMap(Map<String, dynamic> json) => Rutas(
        idUsu: json["id_usu"],
        usuario: json["usuario"],
        email: json["email"],
        estado: json["estado"],
        ruta: json["ruta"],
        permisos: json["permisos"],
        idSesion: json["id_sesion"],
        edoColabora: json["edo_colabora"],
        empresa: json["empresa"],
        multiempresa: json["multiempresa"],
        statuscode: json["statuscode"],
        codigo: json["codigo"],
        mensaje: json["mensaje"],
      );

  Map<String, dynamic> toMap() => {
        "id_usu": idUsu,
        "usuario": usuario,
        "email": email,
        "estado": estado,
        "ruta": ruta,
        "permisos": permisos,
        "id_sesion": idSesion,
        "edo_colabora": edoColabora,
        "empresa": empresa,
        "multiempresa": multiempresa,
        "statuscode": statuscode,
        "codigo": codigo,
        "mensaje": mensaje,
      };
}

// enum Mensaje { OK }

// final mensajeValues = EnumValues({"OK": Mensaje.OK});

// enum Permisos { RWD }

// final permisosValues = EnumValues({"RWD": Permisos.RWD});

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
