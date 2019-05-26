// To parse this JSON data, do
//
//     final spjs110 = spjs110FromJson(jsonString);

import 'dart:convert';

class Spjs110 {
  DateTime fecha;
  String descripcion;
  String cuenta;
  String referencia;
  num eS;
  num importe;
  num saldo;
  int statuscode;
  int codigo;
  String mensaje;

  Spjs110({
    this.fecha,
    this.descripcion,
    this.cuenta,
    this.referencia,
    this.eS,
    this.importe,
    this.saldo,
    this.statuscode,
    this.codigo,
    this.mensaje,
  });

  factory Spjs110.fromRawJson(String str) => Spjs110.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Spjs110.fromJson(Map<String, dynamic> json) => new Spjs110(
        fecha: DateTime.parse(json["fecha"]),
        descripcion: json["descripcion"],
        cuenta: json["cuenta"],
        referencia: json["referencia"],
        eS: json["e_s"],
        importe: json["importe"],
        saldo: json["saldo"],
        statuscode: json["statuscode"],
        codigo: json["codigo"],
        mensaje: json["mensaje"],
      );

  Map<String, dynamic> toJson() => {
        "fecha": fecha.toIso8601String(),
        "descripcion": descripcion,
        "cuenta": cuenta,
        "referencia": referencia,
        "e_s": eS,
        "importe": importe,
        "saldo": saldo,
        "statuscode": statuscode,
        "codigo": codigo,
        "mensaje": mensaje,
      };
}
