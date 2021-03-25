import 'dart:convert';
import 'package:flutter_app/src/models-new/account_model2.dart';
import 'package:flutter_app/src/models-new/gallery_model.dart';
import 'package:flutter_app/src/models-new/service_type_model.dart';

class ServiceModelNew {
  String serviceID;
  String serviceName;
  String description;
  String price;
  String status;
  String estimateTime;
  String summary;
  AccountModel2 account;
  ServiceTypeModel serviceType;
  GalleryModel gallery;

  ServiceModelNew({
    this.serviceID,
    this.serviceName,
    this.description,
    this.summary,
    this.price,
    this.status,
    this.estimateTime,
    this.serviceType,
    this.account,
    this.gallery,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': serviceID,
      'serviceName': serviceName,
      'estimateTime': estimateTime,
      'description': description,
      'summary': summary,
      'price': price,
      'status': status,
      'gallery': gallery.toMap(),
      'account': account.toMap(),
      'serviceType': serviceType.toMap(),
    };
  }

  factory ServiceModelNew.fromMap(Map<String, dynamic> map) {
    return ServiceModelNew(
      serviceID: map['id'].toString(),
      status: map['status'],
      serviceName: map['serviceName'],
      description: map['description'],
      summary: map['summary'],
      estimateTime: map['estimateTime'].toString(),
      price: map['price'].toString(),
      gallery: GalleryModel.fromMap(map['gallery']),
      account: AccountModel2.fromMap(map['account']),
      serviceType: ServiceTypeModel.fromMap(map['serviceType']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceModelNew.fromJson(String source) =>
      ServiceModelNew.fromMap(json.decode(source));
}
