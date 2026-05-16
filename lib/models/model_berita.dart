// To parse this JSON data, do
//
//     final modelBerita = modelBeritaFromJson(jsonString);

import 'dart:convert';

ModelBerita modelBeritaFromJson(String str) => ModelBerita.fromJson(json.decode(str));

String modelBeritaToJson(ModelBerita data) => json.encode(data.toJson());

class ModelBerita {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelBerita({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelBerita.fromJson(Map<String, dynamic> json) => ModelBerita(
    isSuccess: json["is_success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String judulBerita;
  String isiBerita;
  String gbrBerita;
  DateTime tglBerita;

  Datum({
    required this.id,
    required this.judulBerita,
    required this.isiBerita,
    required this.gbrBerita,
    required this.tglBerita,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    judulBerita: json["judul_berita"],
    isiBerita: json["isi_berita"],
    gbrBerita: json["gbr_berita"],
    tglBerita: DateTime.parse(json["tgl_berita"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul_berita": judulBerita,
    "isi_berita": isiBerita,
    "gbr_berita": gbrBerita,
    "tgl_berita": tglBerita.toIso8601String(),
  };
}
