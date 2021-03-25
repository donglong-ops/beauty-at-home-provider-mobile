import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'image_model.dart';
part 'gallery_model.g.dart';

@JsonSerializable()
class GalleryModel {
  List<ImageModel> images;
  GalleryModel({
    this.images,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) =>
      _$GalleryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryModelToJson(this);
}
