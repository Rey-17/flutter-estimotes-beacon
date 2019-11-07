// To parse this JSON data, do
//
//     final beaconsAttachments = beaconsAttachmentsFromJson(jsonString);

import 'dart:convert';

BeaconsAttachments beaconsAttachmentsFromJson(String str) => BeaconsAttachments.fromJson(json.decode(str));

String beaconsAttachmentsToJson(BeaconsAttachments data) => json.encode(data.toJson());

class BeaconsAttachments {
    Meta meta;
    List<Datum> data;

    BeaconsAttachments({
        this.meta,
        this.data,
    });

    factory BeaconsAttachments.fromJson(Map<String, dynamic> json) => BeaconsAttachments(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta == null ? null : meta.toJson(),
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String datumFor;
    String identifier;
    bool public;
    Payload payload;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        this.id,
        this.datumFor,
        this.identifier,
        this.public,
        this.payload,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        datumFor: json["for"] == null ? null : json["for"],
        identifier: json["identifier"] == null ? null : json["identifier"],
        public: json["public"] == null ? null : json["public"],
        payload: json["payload"] == null ? null : Payload.fromJson(json["payload"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "for": datumFor == null ? null : datumFor,
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
    int page;
    int total;
    int totalCount;
    int perPage;

    Meta({
        this.page,
        this.total,
        this.totalCount,
        this.perPage,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        page: json["page"] == null ? null : json["page"],
        total: json["total"] == null ? null : json["total"],
        totalCount: json["total_count"] == null ? null : json["total_count"],
        perPage: json["perPage"] == null ? null : json["perPage"],
    );

    Map<String, dynamic> toJson() => {
        "page": page == null ? null : page,
        "total": total == null ? null : total,
        "total_count": totalCount == null ? null : totalCount,
        "perPage": perPage == null ? null : perPage,
    };
}
