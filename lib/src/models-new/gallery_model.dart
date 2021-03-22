import 'dart:convert';

import 'package:flutter_app/src/models-new/image_model.dart';

class GalleryModel {
  List<ImageModel> images;
  int id;
  GalleryModel({
    this.id,
    this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'images': images?.map((x) => x.toMap())?.toList(),
    };
  }

  factory GalleryModel.fromMap(Map<String, dynamic> map) {
    return GalleryModel(
      id: map['id'],
      images: List<ImageModel>.from(map['images']?.map((x) => ImageModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory GalleryModel.fromJson(String source) =>
      GalleryModel.fromMap(json.decode(source));
}
