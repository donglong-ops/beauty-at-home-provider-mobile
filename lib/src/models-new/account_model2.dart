import 'dart:convert';

import 'package:flutter_app/src/models-new/gallery_model.dart';

class AccountModel2 {
  String id;
  String name;
  String email;
  String role;
  String phone;
  GalleryModel gallery;

  AccountModel2({
    this.id,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.gallery,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': name,
      'email': email,
      'role': role,
      'phone': phone,
      'gallery': gallery.toMap(),
    };
  }

  factory AccountModel2.fromMap(Map<String, dynamic> map) {
    return AccountModel2(
      name: map['displayName'],
      id: map['id'].toString(),
      email: map['email'],
      role: map['role'],
      phone: map['phone'],
      //gallery: GalleryModel.fromMap(map['gallery']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel2.fromJson(String source) =>
      AccountModel2.fromMap(json.decode(source));
}
