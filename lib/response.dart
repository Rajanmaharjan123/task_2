
import 'package:task_2/Data.dart';

import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.ad,
  });

  int page;
  int perPage;
  int total;
  int totalPages;
  List<Data> data;
  Ad ad;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    page: json["page"],
    perPage: json["per_page"],
    total: json["total"],
    totalPages: json["total_pages"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    ad: Ad.fromJson(json["ad"]),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "per_page": perPage,
    "total": total,
    "total_pages": totalPages,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "ad": ad.toJson(),
  };
}

class Ad {
  Ad({
    this.company,
    this.url,
    this.text,
  });

  String company;
  String url;
  String text;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    company: json["company"],
    url: json["url"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "company": company,
    "url": url,
    "text": text,
  };
}