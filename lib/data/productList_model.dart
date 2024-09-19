// To parse this JSON data, do
//
//     final productImageList = productImageListFromJson(jsonString);

import 'dart:convert';

ProductImageList productImageListFromJson(String str) => ProductImageList.fromJson(json.decode(str));

String productImageListToJson(ProductImageList data) => json.encode(data.toJson());

class ProductImageList {
  final int? status;
  final String? message;
  final List<Result>? result;

  ProductImageList({
    this.status,
    this.message,
    this.result,
  });

  factory ProductImageList.fromJson(Map<String, dynamic> json) => ProductImageList(
    status: json["Status"],
    message: json["Message"],
    result: json["Result"] == null ? [] : List<Result>.from(json["Result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  final String? name;
  final String? priceCode;
  final String? imageName;
  final int? id;

  Result({
    this.name,
    this.priceCode,
    this.imageName,
    this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    name: json["Name"],
    priceCode: json["PriceCode"],
    imageName: json["ImageName"],
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "PriceCode": priceCode,
    "ImageName": imageName,
    "Id": id,
  };
}
