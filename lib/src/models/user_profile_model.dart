import 'package:flutter_app/src/models-new/gallery_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
  int uid;
  String displayName,
      email,
      role,
      phone,
      accessToken,
      firebaseRefreshToken,
      idToken;
  GalleryModel gallery;

  UserProfileModel({
    this.gallery,
    this.uid,
    this.displayName,
    this.email,
    this.role,
    this.phone,
    this.accessToken,
    this.firebaseRefreshToken,
    this.idToken,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}
