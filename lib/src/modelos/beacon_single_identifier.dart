// To parse this JSON data, do
//
//     final beaconSingleByIdentifier = beaconSingleByIdentifierFromJson(jsonString);

import 'dart:convert';

BeaconSingleByIdentifier beaconSingleByIdentifierFromJson(String str) => BeaconSingleByIdentifier.fromJson(json.decode(str));

String beaconSingleByIdentifierToJson(BeaconSingleByIdentifier data) => json.encode(data.toJson());

class BeaconSingleByIdentifier {
    Meta meta;
    Data data;

    BeaconSingleByIdentifier({
        this.meta,
        this.data,
    });

    factory BeaconSingleByIdentifier.fromJson(Map<String, dynamic> json) => BeaconSingleByIdentifier(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta == null ? null : meta.toJson(),
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    int id;
    String dataFor;
    String identifier;
    bool public;
    Payload payload;
    DateTime createdAt;
    DateTime updatedAt;

    Data({
        this.id,
        this.dataFor,
        this.identifier,
        this.public,
        this.payload,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        dataFor: json["for"] == null ? null : json["for"],
        identifier: json["identifier"] == null ? null : json["identifier"],
        public: json["public"] == null ? null : json["public"],
        payload: json["payload"] == null ? null : Payload.fromJson(json["payload"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "for": dataFor == null ? null : dataFor,
        "identifier": identifier == null ? null : identifier,
        "public": public == null ? null : public,
        "payload": payload == null ? null : payload.toJson(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}

class Payload {
    String empresa;
    String posicion;

    Payload({
        this.empresa,
        this.posicion,
    });

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        empresa: json["empresa"] == null ? null : json["empresa"],
        posicion: json["posicion"] == null ? null : json["posicion"],
    );

    Map<String, dynamic> toJson() => {
        "empresa": empresa == null ? null : empresa,
        "posicion": posicion == null ? null : posicion,
    };
}

class Meta {
    Meta();

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    );

    Map<String, dynamic> toJson() => {
    };
}
