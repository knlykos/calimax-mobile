// To parse this JSON data, do
//
//     final spjs100 = spjs100FromJson(jsonString);

import 'dart:convert';

List<Spjs100> spjs100FromJson(String str) =>
    new List<Spjs100>.from(json.decode(str).map((x) => Spjs100.fromJson(x)));

String spjs100ToJson(List<Spjs100> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Spjs100 {
  int id;
  String cuentaR;
  int idTc;
  String descTarjeta;
  int clId;
  String nombre;
  int reqNombre;
  String apellidoP;
  int reqApeP;
  String apellidoM;
  int reqApeM;
  DateTime fechaNac;
  int reqFecha;
  String paisNac;
  int reqPais;
  dynamic domicilio;
  int reqDomicilio;
  String telefono;
  int reqTelefono;
  String curp;
  int reqCurp;
  String rfc;
  int reqRfc;
  int idIdent;
  int reqIdent;
  String numIdent;
  int reqNumIdent;
  int edoCard;
  double sdoVales;
  int sdoPuntos;
  double sdoMonedero;
  String edoTarjeta;
  int statuscode;
  int codigo;
  String mensaje;

  Spjs100({
    this.id,
    this.cuentaR,
    this.idTc,
    this.descTarjeta,
    this.clId,
    this.nombre,
    this.reqNombre,
    this.apellidoP,
    this.reqApeP,
    this.apellidoM,
    this.reqApeM,
    this.fechaNac,
    this.reqFecha,
    this.paisNac,
    this.reqPais,
    this.domicilio,
    this.reqDomicilio,
    this.telefono,
    this.reqTelefono,
    this.curp,
    this.reqCurp,
    this.rfc,
    this.reqRfc,
    this.idIdent,
    this.reqIdent,
    this.numIdent,
    this.reqNumIdent,
    this.edoCard,
    this.sdoVales,
    this.sdoPuntos,
    this.sdoMonedero,
    this.edoTarjeta,
    this.statuscode,
    this.codigo,
    this.mensaje,
  });

  obscureCuentaR(String cuentaR) {
    String firsts4Chars = cuentaR.substring(0, 4);
    String lasts4Chars = cuentaR.substring(12, 16);
    return firsts4Chars + ' ' + '●●●●' + ' ' + '●●●●' + ' ' + lasts4Chars;
  }

  factory Spjs100.fromJson(Map<String, dynamic> json) => new Spjs100(
        id: json["id"],
        cuentaR: json["cuenta_r"],
        idTc: json["id_tc"],
        descTarjeta: json["desc_tarjeta"],
        clId: json["cl_id"],
        nombre: json["nombre"],
        reqNombre: json["req_nombre"],
        apellidoP: json["apellido_p"],
        reqApeP: json["req_ape_p"],
        apellidoM: json["apellido_m"],
        reqApeM: json["req_ape_m"],
        fechaNac: DateTime.parse(json["fecha_nac"]),
        reqFecha: json["req_fecha"],
        paisNac: json["pais_nac"],
        reqPais: json["req_pais"],
        domicilio: json["domicilio"],
        reqDomicilio: json["req_domicilio"],
        telefono: json["telefono"],
        reqTelefono: json["req_telefono"],
        curp: json["curp"],
        reqCurp: json["req_curp"],
        rfc: json["rfc"],
        reqRfc: json["req_rfc"],
        idIdent: json["id_ident"],
        reqIdent: json["req_ident"],
        numIdent: json["num_ident"],
        reqNumIdent: json["req_num_ident"],
        edoCard: json["edo_card"],
        sdoVales: json["sdo_vales"].toDouble(),
        sdoPuntos: json["sdo_puntos"],
        sdoMonedero: json["sdo_monedero"].toDouble(),
        edoTarjeta: json["edo_tarjeta"],
        statuscode: json["statuscode"],
        codigo: json["codigo"],
        mensaje: json["mensaje"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cuenta_r": cuentaR,
        "id_tc": idTc,
        "desc_tarjeta": descTarjeta,
        "cl_id": clId,
        "nombre": nombre,
        "req_nombre": reqNombre,
        "apellido_p": apellidoP,
        "req_ape_p": reqApeP,
        "apellido_m": apellidoM,
        "req_ape_m": reqApeM,
        "fecha_nac": fechaNac.toIso8601String(),
        "req_fecha": reqFecha,
        "pais_nac": paisNac,
        "req_pais": reqPais,
        "domicilio": domicilio,
        "req_domicilio": reqDomicilio,
        "telefono": telefono,
        "req_telefono": reqTelefono,
        "curp": curp,
        "req_curp": reqCurp,
        "rfc": rfc,
        "req_rfc": reqRfc,
        "id_ident": idIdent,
        "req_ident": reqIdent,
        "num_ident": numIdent,
        "req_num_ident": reqNumIdent,
        "edo_card": edoCard,
        "sdo_vales": sdoVales,
        "sdo_puntos": sdoPuntos,
        "sdo_monedero": sdoMonedero,
        "edo_tarjeta": edoTarjeta,
        "statuscode": statuscode,
        "codigo": codigo,
        "mensaje": mensaje,
      };
}
